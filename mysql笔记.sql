-- 数据库的操作

	-- 链接数据库
	mysql -uroot -p
	mysql -uroot -p3405
	
	-- 退出数据库
	exit/quit/ctrl+d
	-- sql语句最后需要有分号；结尾
	-- 显示数据库版本
	select version();
	
	-- 显示时间
	select now();
	
	-- 查看所有数据库
	show databases;
	
	-- 创建数据库
	--  create database 数据库名 charset=utf8；
	create database python2;
	create database python2new charset=utf8；
	
	-- 查看创建数据库语句
	-- show create database ....
	show crteate database python2;
	
	-- 查看当前使用的数据库
	select database();
	
	-- 使用数据库
	-- use 数据库的名字
	use python2new;
	
	-- 删除数据库
	--反引号`在tab键上面
	drop database python2;
	drop database `python2`;
	
	
--数据库操作2

	-- 查看当前数据库中所有表
	show tables;
	
	-- 创建表
	-- auto_increment 表示自动增长
	-- not null 表示不能为空
	-- primary key 表示主键
	-- default 默认值
	-- create table 数据表名字 (字段 类型 约束[，字段 类型 约束]);
	
	create table xxx(id int, name varchar(30));
	create table yyy(id int primary key not null auto_increment, name varchar(30));
	
	-- 创建 students 表（id、name、age、high、gender、cls_id）
	-- 小数：decimal(5,2)共存5位数，小数保留两位
	-- 枚举类型：enum("","","")
	create table students(
	id int unsigned not null auto_increment primary key,
	name varchar(30),
	age tinyint unsigned default 0,
	high decimal(5.2),
	gender enum("男","女","保密") default "保密",
	cls_id int unsigned
	);
	
	insert into students values(0, "老王", 18, 188.88, "男", 0);
	select * from students;
	
	-- 创建classes表（id、name）
	create table classes(
	id int unsigned not null auto_increment primary key,
	name varchar(30)
	);
	insert into classes values(0, "小王");
	select * from classes;
	-- 查看表的创建语句
	-- show create table 表名字;
	show create table students;
	
	-- 查看表结构
	-- desc 数据表的名字;
	desc xxx;
	-- 修改表-添加字段
	-- alter table 表名 add 列名 类型及约束;
	alter table students add birthday datetime;
	
	-- 修改表-修改字段：不重命名版
	-- alter table 表名 modify 列名 类型及约束;
	alter table students modify birthday date;
	
	-- 修改表-修改字段：重命名版
	-- alter table 表名 change 原名 新名 类型及约束;
	alter table students change birthday birth date default "2000-01-01";
	
	-- 修改表-删除字段
	-- alter table 表名 drop 列名;
	alter table students drop high;
	
	-- 删除表
	-- drop table 表名;
	-- drop database 数据表;
	drop table xxx;
	
	
	
-- 增删改查（crud）

	-- 增加
		-- 全列插入
		-- insert [into] 表名 values(...)
		-- 主键字段 可以用 0 null default 来占位
		-- 向 classes 表中插入 一个班级
		insert into classes values(0, "菜鸟");
		

+--------+------------------------+------+-----+------------+----------------+
| Field  | Type                   | Null | Key | Default    | Extra          |
+--------+------------------------+------+-----+------------+----------------+
| id     | int(10) unsigned       | NO   | PRI | NULL       | auto_increment |
| name   | varchar(30)            | YES  |     | NULL       |                |
| age    | tinyint(3) unsigned    | YES  |     | 0          |                |
| gender | enum('男','女','保密') | YES  |     | 保密       |                |
| cls_id | int(10) unsigned       | YES  |     | NULL       |                |
| birth  | date                   | YES  |     | 2000-01-01 |                |
+--------+------------------------+------+-----+------------+----------------+
		-- 向 students 表插入 一个学生信息
		insert into students values(0, "小李飞刀", 20, "女", 1, "1990-01-01");
		insert into students values(null, "小李飞刀", 20, "女", 1, "1990-01-01");
		insert into students values(default, "小李飞刀", 20, "女", 1, "1990-01-01");
		
		-- 枚举中 的下标从1 开始
		insert into students values(default, "小李飞刀", 20, 2, 1, "1990-01-01");
		
		-- 部分插入
		-- insert into 表名 (列1,...) values(值1,...)
		insert into students (name, gender) values ("小乔", 2);
		
		-- 多行插入
		insert into students (name, gender) values ("大桥", 2), ("貂蝉", 2);
		insert into students values(default, "西施", 20, "女", 1, "1990-01-01"), (default, "王昭君", 20, "女", 1, "1990-01-01");
		
	-- 修改
	-- update 表名 set 列1=值1，列2=值2... where 条件;
	update students set gender=1; -- 全部修改
	update students set gender=1 where name="小李飞刀"; -- 只要name是小李飞刀的 全部修改
	update students set age=22, gender=2 where id=3; -- 只要id为3 进行修改
	
	-- 删除 
		-- 物理删除
		-- delete from 表名 where 条件
		delete from students;  -- 整个数据表中的所有数据全部删除
		delete from students where name="小李飞刀";
		
		
		-- 逻辑删除
		-- 用一个字段来表示 这条信息是否已经不能再使用了
		-- 给 students 表添加一个 is_delete 字段 bit 类型
		alter table students add  is_delete bit default 0;
		select * from students where is_delete=0;
		
		update students set is_delete=1 where id=6;
		
	
	-- 查询基本使用 
		-- 查询所有列
		-- select * from 表名;
		select * from students;
		
		-- 指定条件查询
		select * from students where name="小李飞刀";
		select * from students where id>3;
		
		-- 查询指定列
		-- select 列1,列2,... from 表名;
		select name,gender from students;
		

		-- 可以使用as为列或表指定别名
		-- select 字段[as 别名] , 字段[as 别名] from 数据表 where ....;
		select name as 姓名,gender as 性别 from students;
		
		
		-- 字段的顺序
		select id as 序号,gender as 性别,name as 姓名 from students;
		