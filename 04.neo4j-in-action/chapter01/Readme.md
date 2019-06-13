# Chapter 1

## 1.stucture

Java

```console
.
├── java
│   └── com
│       └── manning
│           └── neo4jia
│               └── chapter01
│                   ├── Main.java #主类，调用4个方法：图数据生成、查询、JDBC数据生成、查询
│                   ├── Constants.java #常量
│                   ├── DataGenerator.java #定义users生成接口
│                   ├── Neo4jDataGenerator.java
│                   ├── JdbcDataGenerator.java 
│                   ├── FriendsOfFriendsFinder.java #定义各深度查询接口
│                   └── Neo4jFriendsOfFriendsFinder.java 
│                   ├── JdbcFriendsOfFriendsFinder.java 
└── resources
    ├── META-INF
    │   └── spring
    │       └── module-context.xml #定义JDBC数据源
    ├── create-h2.sql #新建表结构+索引
    ├── create-mysql.sql #新建表结构+索引
    ├── db.properties #JDBC属性配置
    └── log4j.properties
```



## 2.main
```java
public class Main {
    public static void main(String[] args){
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath*:META-INF/spring/module-context.xml");

        generateGraphData();
        runTraversalQuery(context);
        generatedJdbcData(context);
        runJdbcQuery(context);

    }
}
```

