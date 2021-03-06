/**
 * (c) 2003-2017 MuleSoft, Inc. The software in this package is published under the terms of the Commercial Free Software license V.1 a copy of which has been included with this distribution in the LICENSE.md file.
 */
package org.mule.modules.neo4j.internal.client;

import static com.google.common.base.Joiner.on;
import static com.google.common.base.Optional.fromNullable;
import static com.google.common.base.Strings.emptyToNull;
import static com.google.common.collect.Iterables.transform;
import static java.lang.String.format;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;

import org.mule.modules.neo4j.internal.connection.Neo4JConnection;
import org.mule.modules.neo4j.internal.util.FormatFunction;
import org.neo4j.driver.v1.Record;
import org.neo4j.driver.v1.Value;
import org.neo4j.driver.v1.util.Pair;

import com.google.common.collect.ImmutableMap;

public class Neo4JClientImpl implements Neo4JClient {

    private static final Map<String, Object> EMPTY_MAP = Collections.emptyMap();
    private final Neo4JConnection connection;
    private static final Logger logger = Logger.getLogger(Neo4JClientImpl.class);

    public Neo4JClientImpl(Neo4JConnection connection) {
        this.connection = connection;
    }

    @Override
    public void createNode(String label, Map<String, Object> parameters) {
        execute("CREATE (a:`%s` %s) RETURN a", label, parameters);
    }

    @Override
    public List<Map<String, Object>> selectNodes(String label, Map<String, Object> parameters) {
        return execute("MATCH (a:`%s` %s) RETURN a", label, parameters);
    }

    @Override
    public void updateNodes(String label, Map<String, Object> parameters, Map<String, Object> setParameters) {
        execute("MATCH (a:`%s` %s) %s RETURN a", label, parameters, setParameters);
    }

    @Override
    public void deleteNodes(String label, boolean removeRelationships, Map<String, Object> parameters) {
        execute(format("MATCH (a:`%%s` %%s) %s DELETE a", removeRelationships ? "DETACH" : ""), label, parameters);
    }

    @Override
    public List<Map<String, Object>> execute(String cqlStatement, Map<String, Object> parameters) {
        if (logger.isDebugEnabled()) {
            logger.debug("cqlStatement=" + cqlStatement);
            logger.debug("parameters=" + parameters);
        }
        List<Map<String, Object>> result = new ArrayList<>();
        for (Record record : connection.getSession().run(cqlStatement, parameters).list()) {
            Map<String, Object> resultMap = new HashMap<>();
            for (Pair<String, Value> pair : record.fields()) {
                resultMap.put(pair.key(), convert(pair.value()));
            }
            result.add(resultMap);
        }
        return result;
    }

    private List<Map<String, Object>> execute(String cql, String label, Map<String, Object> parameters) {
        return execute(cql, label, parameters, EMPTY_MAP);
    }

    private List<Map<String, Object>> execute(String cql, String label, Map<String, Object> parameters, Map<String, Object> setParameters) {
        return execute(format(cql, label, wrapAndJoin("{%s}", "`%1$s`:$props.`%1$s`", parameters), wrapAndJoin("SET %s", "a.`%1$s` = $setProps.`%1$s`", setParameters)),
                ImmutableMap.<String, Object>builder().put("props", fromNullable(parameters).or(EMPTY_MAP)).put("setProps", fromNullable(setParameters).or(EMPTY_MAP)).build());
    }

    private String wrapAndJoin(String wrapper, String template, Map<String, Object> parameters) {
        return fromNullable(emptyToNull(on(",").join(transform(fromNullable(parameters).or(EMPTY_MAP).keySet(), new FormatFunction(template)))))
                .transform(new FormatFunction(wrapper)).or("");
    }

    private Object convert(Value value) {
        Map<String, Object> result = new HashMap<>();
        for (String key : value.keys()) {
            result.put(key, convert(value.get(key)));
        }
        return result.isEmpty() ? value.asObject() : result;
    }
}
