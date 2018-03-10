USE master   
  
go    
  
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[p_killspid]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)   
    DROP PROCEDURE [dbo].[p_killspid]   
go   

create   proc   p_killspid    
@dbname   varchar(200) --要关闭进程的数据库名    
as        
declare   @programName     nvarchar(200),    
@spid   nvarchar(20)    
  
declare   cDblogin   cursor   for    
select   cast(spid   as   varchar(20))  AS spid   from   master..sysprocesses   where   dbid=db_id(@dbname)    
open   cDblogin   
fetch   next   from   cDblogin   into   @spid    
while   @@fetch_status=0    
begin       
--防止自己终止自己的进程     
--否则会报错不能用KILL 来终止您自己的进程。      
IF  @spid <> @@SPID   
    exec( 'kill   '+@spid)    
fetch   next   from  cDblogin   into   @spid    
end        
close   cDblogin    
deallocate   cDblogin   
go    

 exec   p_killspid     movies
--强制性关闭数据库的所有连接 
  
DROP DATABASE movies  --删除先有的数据库
go


create database movies; --新建数据库
go
use movies; --新建数据库名为movies
go
create table types --新建电影分类表
(id int identity(1,1) primary key,
tname varchar(50) not null
)

go
create table movielist
(
id int identity(1,1) primary key, --id 主键
mname varchar(100) not null, --电影名称 不能为空
maker varchar(50), --电影作者
url varchar(100),--电影地址
img varchar(100),--电影图片地址
playtimes int default(0),--点击量
isrecommend bit default(0),--有没有付费上头条
onlinetime datetime, --电影上映时间
brief text, --电影简介
tid int, --电影分类
																	--（代表唯一性，在后台中我需要使用到） 不能为空
constraint mtfk foreign key(tid) references types(id) -- 与电影分类表建立关系
)

go 

create table  mH_admin --新建管理员登录表
(
	id int identity(1,1) primary key, --主键 id自增
	username  varchar(16) not null, --用户名
	userpwd varchar(30) not null,--用户密码
	userlevel int not null,--管理员等级 0表示普通管理员，1表示超级管理员
)
go

create table mH_admin_log --新建管理操作日志
(
	id int identity(1,1) primary key,
	adminname varchar(16) not null, --管理员名称 不能为空
	adminip varchar(20) not null,--管理员登录IP地址 不能为空
	admintime datetime not null,--操作时间 不能为空
	admintip text,--说明 可以为空
	adminmovies varchar(20), --相关电影的内容
)
go

create table  role_menu --新建管理员登录表
(
	id int identity(1,1) primary key, --主键 id自增
	username  varchar(16) not null, --用户名
	userpwd varchar(30) not null,--用户密码
	userlevel int not null,--管理员等级 0表示普通管理员，1表示超级管理员
)
go


--插入电影分类
insert into types(tname)  values('喜剧');
insert into types(tname)  values('爱情');
insert into types(tname)  values('科幻');
insert into types(tname)  values('伦理');
insert into types(tname)  values('惊悚');
insert into types(tname)  values('动作');


--插入电影信息
insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('夏洛特烦恼','jan','movies/hu.mp4','images/movies/xltfn.png',80,0,'2017-10-10 12:23:00','《夏洛特烦恼》是开心麻花2012年首度推出的话剧，由闫非和彭大魔联合编剧、执导。2013、2014、2015年仍在上演。该作讲述了一个普通人在穿越重回到高中校园并实现了种种梦想的不可思议的经历。',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('我是证人','安尚勋','movies/hu.mp4','images/movies/wszr.png',89,0,'2015-10-30 12:23:00','《我是证人》是由安尚勋执导，顾小白编剧，杨幂、鹿晗 、王景春、朱亚文等主演的青春悬疑电影，改编自韩国电影《盲证》，影片于2015年10月30日中国内地上映。该片讲述一起谋杀案出现了两位证言不同的目击证人，而两人却在之后联合追缉凶手的惊险故事。',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('澳门风云2','刘伟强','movies/hu.mp4','images/movies/amfy2.png',380,1,'2016-10-10 2:23:00','合家欢贺岁喜剧《澳门风云2》由博纳影业集团出品，王晶导演，刘伟强监制，由周润发、张家辉 、刘嘉玲、余文乐、王诗龄、 胡然、吴樾、金巧巧、黄德斌、袁泉、孟瑶等联袂主演。《澳门风云2》延续了前作《澳门风云》的故事，讲述外号“赢尽天下无敌手”的石一坚退隐江湖之后的故事。该片已于2015年2月19日（农历大年初一）正式全国上映。',3);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('盗墓笔记','李仁港','movies/hu.mp4','images/movies/dmbj.png',100,0,'2014-11-10 12:23:00','《盗墓笔记》是由上海电影（集团）有限公司、乐视影业（北京）有限公司、南派泛娱有限公司联合出品的动作探险片，由李仁港执导，井柏然、鹿晗、王景春、马思纯等主演。该片改编自南派三叔的同名小说，讲述了醉心于古建筑的吴邪在三叔的带领下，与张起灵、阿宁、潘子、王胖子，开始了一场前所未有的冒险故事。该片于2016年8月5日在中国上映。',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('第三种爱情','李宰汉','movies/hu.mp4','images/movies/dszaq.png',40,0,'2013-10-10 12:23:00','《第三种爱情》是由李宰汉执导，窦霞担当制片人，刘亦菲、宋承宪领衔主演、欧汉声、孟佳、江语晨等联袂出演的一部现代都市爱情电影。影片于2015年9月25日在中国大陆上映。影片改编自中国作家自由行走andrea的同名小说，讲述了高冷律师邹雨与“霸道总裁”林启正之间坎坷有趣的爱情故事、姐妹等四人之间的爱恨纠葛。',5);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('疯狂外星人','蒂姆·约翰逊','movies/hu.mp4','images/movies/fkwxr.png',190,0,'2013-5-10 12:23:00','《疯狂外星人》是梦工厂于2015年出品的一部动画片，影片由蒂姆·约翰逊执导，吉姆·帕森斯、蕾哈娜、史蒂夫·马丁和詹妮弗·洛佩兹等联袂献声配音。影片于2015年3月27日在美国率先放映，将于2015年4月24日在中国内地上映。影片由《疯狂原始人》和《驯龙高手》的制作班底打造，改编自儿童小说《斯麦克节的真正意义》，讲述一个11岁地球女孩小零的妈妈被入侵地球的波波星人绑架了，她被迫开车前往弗罗里达逃难一路上遇到的故事。',6);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('摩卡行动','姜国民','movies/hu.mp4','images/movies/mkxd.png',60,0,'2014-05-10 12:23:00','《魔卡行动》是由姜国民执导，黄飞珏编剧，乔任梁、张馨予、任达华等主演的动作喜剧电影，影片于2015年10月16日上映。该片讲述七人组成的“米兰魔盗团”因一条老街的收购而引发的一系列环环相扣的故事。',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('怦然星动','陈国辉','movies/hu.mp4','images/movies/prxd.png',70,0,'2012-12-10 12:23:00','《怦然星动》是欢瑞世纪影视传媒股份有限公司、海宁嘉行天下影视文化有限公司、光线传媒有限公司联合出品，由陈国辉执导，杨幂、李易峰领衔主演的爱情片。该片讲述了金牌经纪人田心与歌手苏星宇之间相互禁忌又充满笑料的爱情故事，是中国首部呈现娱乐圈纷繁百态的都市爱情片。影片于2015年12月3日在中国内地上映。',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('万万没想到','易小星','movies/hu.mp4','images/movies/wwmxd.png',20,0,'2013-06-10 12:23:00','《万万没想到》是2015年叫兽易小星执导的奇幻喜剧电影，由黄建新监制，韩寒任艺术指导，杨子姗、白客、陈柏霖、马天宇、刘循子墨等出演。该片讲述自诩为本地妖王的小妖王大锤遇到唐僧师徒后，发生的一系列冒险故事。影片于2015年12月18日在中国大陆上映。',3);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('校花的贴身高手','吴建新','movies/hu.mp4','images/movies/xhdtsgs.png',170,0,'2014-10-16 12:23:00','《校花的贴身高手》[1]  是根据鱼人二代同名小说改编，由吴建新执导，李宗霖、曹曦月、杨芸晴、万玮乔、邵雨薇等主演的青春网络剧。',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('小黄人大眼萌','凯尔·巴尔达、皮艾尔·柯芬','movies/hu.mp4','images/movies/xhrdym.png',100,0,'2017-10-10 12:23:00','《小黄人大眼萌》是一部2015年的美国喜剧动画电影，该影片由凯尔·巴尔达、皮艾尔·柯芬执导，桑德拉·布洛克、皮艾尔·柯芬、史蒂夫·卡瑞尔配音，由照明娱乐公司和环球影业联合出品。该影片讲述了小黄人的历史以及他们要找到强大的新主人，并辅佐他完成作恶事业的故事，背景涉及到伦敦、纽约等几个大城市，该片于2015年9月13日以3D及IMAX 3D格式在中国上映。',5);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('小时代3','郭敬明','movies/hu.mp4','images/movies/xsd3.png',99,0,'2015-10-16 12:23:00','《小时代3：刺金时代》是由郭敬明执导，杨幂、郭采洁、柯震东、郭碧婷、陈学冬、谢依霖等主演的青春时尚都市电影。该片改编自郭敬明同名小说，影片主要讲述了林萧、顾里、南湘、唐宛如，四个从小一起长大的好姐妹大学毕业进入职场，开始了新的旅程的故事。于2014年7月17日全国公映。',6);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('有种你爱我','李欣蔓','movies/hu.mp4','images/movies/yznaw.png',60,0,'2007-10-10 12:23:00','《有种你爱我》是李欣蔓导演的一部爱情性感喜剧电影，由郑恺、江一燕等主演，于2015年2月6日上映。该片主要是探讨女权主义及女性男性博弈话题的电影。影片不拘泥于爱情性感喜剧的传统模式，延展出各类典型的中国家庭现象，预演了当下年轻人在情爱、婚姻以及性选择上的多种可能，诠释了“性可以自由，但爱必须是唯一”的新式爱情观。',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('探灵档案','彭发','movies/hu.mp4','images/movies/tlda.png',10,0,'2015-10-30 12:23:00','《探灵档案》一部由“亚洲类型片大师”彭发执导，陈冠希、商天娥、彭新智、沈婵娟、臧金生、邓丽欣、黄德斌、滕丽名主演的大型悬疑推理网络剧。',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('看不见的客人','奥里奥尔·保罗','movies/hu.mp4','images/movies/kbjdkr.png',180,0,'2015-11-10 12:23:00','《看不见的客人》是奥里奥尔·保罗执导，马里奥·卡萨斯、阿娜·瓦格纳、芭芭拉·蓝妮、何塞·卡罗纳多主演的悬疑电影。该片于2017年1月6日在西班牙上映。该片讲述了企业家艾德里安在事业如日中天之时被卷入一桩谋杀案中，为了洗脱罪名，他请来了金牌女律师弗吉尼亚为自己辩护。',3);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('正义联盟','扎克·施奈德','movies/hu.mp4','images/movies/zylm.png',125,0,'2013-11-10 12:23:00','《正义联盟》是由扎克·施奈德执导，克里斯·特里奥、乔斯·韦登编剧，本·阿弗莱克，亨利·卡维尔，盖尔·加朵等主演的动作奇幻电影。改编自DC漫画，是DC扩展宇宙的第五部影片。故事发生在《蝙蝠侠大战超人：正义黎明》之后，主要讲述了面对一个全新的世界威胁，超人、蝙蝠侠、神奇女侠、闪电侠、海王和钢骨六位英雄聚首，与这股未知的威胁对抗的故事。 该片于2017年11月16日在中国内地部分影院提前点映，11月17日与北美同步上映。',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('十万个冷笑话','寒舞','movies/hu.mp4','images/movies/swglxh.png',127,0,'2016-09-10 12:23:00','《十万个冷笑话》是根据漫画家寒舞的作品改编的动画，由卢恒宇，李姝洁导演。动画第一季于2012年7月11日播出，共12集，已完结，第二季于2013年12月31日开播。',5);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('英伦对决','马丁·坎贝尔','movies/hu.mp4','images/movies/yldj.png',128,0,'2014-11-10 12:23:00','《英伦对决》是由中国、英国联合制作的动作惊悚片，由新西兰导演马丁·坎贝尔执导，成龙、皮尔斯·布鲁斯南领衔主演。该片于2017年9月30日在中国内地上映。《英伦对决》根据史蒂芬·莱瑟1992年出版的小说《中国人》改编，讲述了生活在英国的越南华裔关玉明的女儿在恐怖袭击中不幸遇难，为了给女儿讨回公道，独自踏上向恐怖组织复仇之路的故事。',6);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('雷神3','塔伊加·维迪提','movies/hu.mp4','images/movies/ls3.png',170,0,'2015-10-15 12:23:00','《雷神3：诸神黄昏》（Thor: Ragnar?k）是漫威影业出品的一部科幻兼奇幻动作电影，取材自漫威漫画《诸神黄昏》，是漫威电影宇宙的第十七部电影。由塔伊加·维迪提执导，克里斯·海姆斯沃斯、汤姆·希德勒斯顿、凯特·布兰切特、马克·鲁法洛、泰莎·汤普森等主演。于2017年11月3日在美国上映，中国同步上映。该片讲述失去了雷霆之锤的雷神索尔被囚禁在宇宙另一端的星系中，争分夺秒试图回到阿斯加德，阻止拥有至尊神力的死神海拉发动巨大劫难——诸神的黄昏，摧毁阿斯加德及其所有的文明。',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('你的名字','新海诚','movies/hu.mp4','images/movies/ndmz.png',230,1,'2013-10-15 12:23:00','《你的名字。》是由新海诚执导，由神木隆之介、上白石萌音担任主要配音的一部原创日本动画电影。作品于2016年8月26日在日本上映。中国内地于2016年12月2日上映。作品讲述了男女高中生在梦中相遇，并寻找彼此的故事。北京时间2017年8月26日零点于中国大陆的PPTV、bilibili、爱奇艺、优酷网络首播。',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('无间道','刘伟强、麦兆辉','movies/hu.mp4','images/movies/wjd.png',420,1,'2014-10-30 12:23:00','《无间道》是寰亚电影发行公司于2002年出品的一部警匪片，由刘伟强、麦兆辉执导，刘德华、梁朝伟、黄秋生、曾志伟等主演。该片讲述的是两个身份混乱的男人分别为警方和黑社会的卧底，经过一场激烈的角斗，他们决心要寻回自己的故事。2003年，该片获得了第22届香港电影金像奖最佳电影奖、第40届台湾电影金马奖最佳影片等奖项，梁朝伟凭借该片获得第22届香港电影金像奖最佳男主角奖等奖项。',3);


insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('战狼','吴京','movies/hu.mp4','images/movies/zl.png',320,1,'2015-10-10 12:23:00','《战狼》是由吴京执导的现代军事战争片，该片由吴京、余男、倪大红、斯科特·阿金斯 、周晓鸥等主演。该影片属于国内首部3D动作战争电影，历时七年全力打造，《战狼》真实呈现了一场中外边境战争，也让堪称“东方之狼”的特种兵战队及高能战士首次登陆大银幕。讲述的是小人物成长为拯救国家和民族命运的孤胆英雄的传奇故事。该影片于2015年4月2日全国上映。2015年6月20日，《战狼》在成龙动作电影周上包揽了最佳动作片、最佳动作男演员、最佳特技、最佳打斗场面设计四项大奖。2016年8月6日，第20届华鼎 .',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('七月与安生','陈可辛','movies/hu.mp4','images/movies/qyyas.png',220,0,'2013-09-10 12:23:00','《七月与安生》是由极客影业、嘉映影业、阿里巴巴影业集团有限公司联合出品，陈可辛监制，曾国祥执导，周冬雨、马思纯主演的青春爱情电影。该片根据作家庆山（安妮宝贝）的同名小说改编，讲述“七月”和“安生”两个女孩从13岁开始相识相知、相爱相杀的成长故事。 该片于2016年9月14日在中国大陆上映，在第53届金马奖上获得最佳女主角奖，并获得最佳导演、最佳改编剧本等七项提名；在第36届金像奖上获得最佳电影、最佳女主角、最佳导演、最佳编剧等12项提名。',5);


--添加登陆用户信息

insert into mH_admin values ('user1','C4CA4238A0B923820DCC509A6F7584',1); --用户名user1(小写+数字) 密码是md5 明文：1 (数字) , 超级管理员
insert into mH_admin values ('user2','C81E728D9D4C2F636F067F89CC1486',0); --用户名user2(小写+数字) 密码是md5 明文：2 (数字) , 普通管理员

--添加管理员操作日志信息
insert into  mH_admin_log values('wxh','192.168.3.1','2017-12-09 15:05','登录了后台管理系统','无'); --0表示没有和视频相关信息
insert into  mH_admin_log values('nxl','192.168.133.1','2017-12-09 15:05','添加了一部电影','《战狼》'); --0表示没有和视频相关信息
insert into  mH_admin_log values('user1','170.0.3.1','2017-12-11 15:05','编辑了视频信息','《万万没想到》'); --0表示没有和视频相关信息
insert into  mH_admin_log values('user1','192.112.3.1','2017-10-09 15:05','修改了登录密码','无'); --0表示没有和视频相关信息
insert into  mH_admin_log values('wxh','192.112.3.1','2017-11-09 15:45','添加了一部电影','《你的名字》'); --0表示没有和视频相关信息
insert into  mH_admin_log values('nxl','127.105.3.1','2017-10-09 05:05','修改了登录密码','无'); --0表示没有和视频相关信息

select * from types --查询分类表 检查信息是否完全
select * from movielist --查询电影表 检查信息是否完全
select * from mH_admin --查询登录管理员表 检查信息是否完全
select * from mH_admin_log  --查询管理员操作日志表 检查信息是否完全
