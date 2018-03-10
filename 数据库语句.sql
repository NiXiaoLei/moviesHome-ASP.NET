USE master   
  
go    
  
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[p_killspid]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)   
    DROP PROCEDURE [dbo].[p_killspid]   
go   

create   proc   p_killspid    
@dbname   varchar(200) --Ҫ�رս��̵����ݿ���    
as        
declare   @programName     nvarchar(200),    
@spid   nvarchar(20)    
  
declare   cDblogin   cursor   for    
select   cast(spid   as   varchar(20))  AS spid   from   master..sysprocesses   where   dbid=db_id(@dbname)    
open   cDblogin   
fetch   next   from   cDblogin   into   @spid    
while   @@fetch_status=0    
begin       
--��ֹ�Լ���ֹ�Լ��Ľ���     
--����ᱨ������KILL ����ֹ���Լ��Ľ��̡�      
IF  @spid <> @@SPID   
    exec( 'kill   '+@spid)    
fetch   next   from  cDblogin   into   @spid    
end        
close   cDblogin    
deallocate   cDblogin   
go    

 exec   p_killspid     movies
--ǿ���Թر����ݿ���������� 
  
DROP DATABASE movies  --ɾ�����е����ݿ�
go


create database movies; --�½����ݿ�
go
use movies; --�½����ݿ���Ϊmovies
go
create table types --�½���Ӱ�����
(id int identity(1,1) primary key,
tname varchar(50) not null
)

go
create table movielist
(
id int identity(1,1) primary key, --id ����
mname varchar(100) not null, --��Ӱ���� ����Ϊ��
maker varchar(50), --��Ӱ����
url varchar(100),--��Ӱ��ַ
img varchar(100),--��ӰͼƬ��ַ
playtimes int default(0),--�����
isrecommend bit default(0),--��û�и�����ͷ��
onlinetime datetime, --��Ӱ��ӳʱ��
brief text, --��Ӱ���
tid int, --��Ӱ����
																	--������Ψһ�ԣ��ں�̨������Ҫʹ�õ��� ����Ϊ��
constraint mtfk foreign key(tid) references types(id) -- ���Ӱ���������ϵ
)

go 

create table  mH_admin --�½�����Ա��¼��
(
	id int identity(1,1) primary key, --���� id����
	username  varchar(16) not null, --�û���
	userpwd varchar(30) not null,--�û�����
	userlevel int not null,--����Ա�ȼ� 0��ʾ��ͨ����Ա��1��ʾ��������Ա
)
go

create table mH_admin_log --�½����������־
(
	id int identity(1,1) primary key,
	adminname varchar(16) not null, --����Ա���� ����Ϊ��
	adminip varchar(20) not null,--����Ա��¼IP��ַ ����Ϊ��
	admintime datetime not null,--����ʱ�� ����Ϊ��
	admintip text,--˵�� ����Ϊ��
	adminmovies varchar(20), --��ص�Ӱ������
)
go

create table  role_menu --�½�����Ա��¼��
(
	id int identity(1,1) primary key, --���� id����
	username  varchar(16) not null, --�û���
	userpwd varchar(30) not null,--�û�����
	userlevel int not null,--����Ա�ȼ� 0��ʾ��ͨ����Ա��1��ʾ��������Ա
)
go


--�����Ӱ����
insert into types(tname)  values('ϲ��');
insert into types(tname)  values('����');
insert into types(tname)  values('�ƻ�');
insert into types(tname)  values('����');
insert into types(tname)  values('���');
insert into types(tname)  values('����');


--�����Ӱ��Ϣ
insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�����ط���','jan','movies/hu.mp4','images/movies/xltfn.png',80,0,'2017-10-10 12:23:00','�������ط��ա��ǿ����黨2012���׶��Ƴ��Ļ��磬���ƷǺ����ħ���ϱ�硢ִ����2013��2014��2015���������ݡ�����������һ����ͨ���ڴ�Խ�ػص�����У԰��ʵ������������Ĳ���˼��ľ�����',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('����֤��','����ѫ','movies/hu.mp4','images/movies/wszr.png',89,0,'2015-10-30 12:23:00','������֤�ˡ����ɰ���ѫִ������С�ױ�磬���ݡ�¹�� ���������������ĵ����ݵ��ഺ���ɵ�Ӱ���ı��Ժ�����Ӱ��ä֤����ӰƬ��2015��10��30���й��ڵ���ӳ����Ƭ����һ��ıɱ����������λ֤�Բ�ͬ��Ŀ��֤�ˣ�������ȴ��֮������׷�����ֵľ��չ��¡�',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('���ŷ���2','��ΰǿ','movies/hu.mp4','images/movies/amfy2.png',380,1,'2016-10-10 2:23:00','�ϼһ�����ϲ�硶���ŷ���2���ɲ���Ӱҵ���ų�Ʒ���������ݣ���ΰǿ���ƣ������󷢡��żһ� �������ᡢ�����֡���ʫ�䡢 ��Ȼ�����С������ɡ��Ƶ±�ԬȪ���������������ݡ������ŷ���2��������ǰ�������ŷ��ơ��Ĺ��£�������š�Ӯ�������޵��֡���ʯһ����������֮��Ĺ��¡���Ƭ����2015��2��19�գ�ũ�������һ����ʽȫ����ӳ��',3);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('��Ĺ�ʼ�','���ʸ�','movies/hu.mp4','images/movies/dmbj.png',100,0,'2014-11-10 12:23:00','����Ĺ�ʼǡ������Ϻ���Ӱ�����ţ����޹�˾������Ӱҵ�����������޹�˾�����ɷ������޹�˾���ϳ�Ʒ�Ķ���̽��Ƭ�������ʸ�ִ��������Ȼ��¹�ϡ�����������˼�������ݡ���Ƭ�ı������������ͬ��С˵�������������ڹŽ�������а������Ĵ����£��������顢���������ӡ������ӣ���ʼ��һ��ǰ��δ�е�ð�չ��¡���Ƭ��2016��8��5�����й���ӳ��',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�����ְ���','���׺�','movies/hu.mp4','images/movies/dszaq.png',40,0,'2013-10-10 12:23:00','�������ְ��顷�������׺�ִ�����ϼ������Ƭ�ˣ�����ơ��γ����������ݡ�ŷ�������ϼѡ����ﳿ�����ǳ��ݵ�һ���ִ����а����Ӱ��ӰƬ��2015��9��25�����й���½��ӳ��ӰƬ�ı����й�������������andrea��ͬ��С˵�������˸�����ʦ�����롰�Ե��ܲá�������֮�俲����Ȥ�İ�����¡����õ�����֮��İ��޾���',5);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('���������','��ķ��Լ��ѷ','movies/hu.mp4','images/movies/fkwxr.png',190,0,'2013-5-10 12:23:00','����������ˡ����ι�����2015���Ʒ��һ������Ƭ��ӰƬ�ɵ�ķ��Լ��ѷִ������ķ����ɭ˹���ٹ��ȡ�ʷ�ٷ�����ղ�ݸ��������ȵ���������������ӰƬ��2015��3��27�����������ȷ�ӳ������2015��4��24�����й��ڵ���ӳ��ӰƬ�ɡ����ԭʼ�ˡ��͡�ѱ�����֡���������״��죬�ı��Զ�ͯС˵��˹��˽ڵ��������塷������һ��11�����Ů��С������豻���ֵ���Ĳ������˰���ˣ������ȿ���ǰ�������������һ·�������Ĺ��¡�',6);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('Ħ���ж�','������','movies/hu.mp4','images/movies/mkxd.png',60,0,'2014-05-10 12:23:00','��ħ���ж������ɽ�����ִ�����Ʒ����磬����������ܰ�衢�δﻪ�����ݵĶ���ϲ���Ӱ��ӰƬ��2015��10��16����ӳ����Ƭ����������ɵġ�����ħ���š���һ���Ͻֵ��չ���������һϵ�л�����۵Ĺ��¡�',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('��Ȼ�Ƕ�','�¹���','movies/hu.mp4','images/movies/prxd.png',70,0,'2012-12-10 12:23:00','����Ȼ�Ƕ����ǻ�������Ӱ�Ӵ�ý�ɷ����޹�˾��������������Ӱ���Ļ����޹�˾�����ߴ�ý���޹�˾���ϳ�Ʒ���ɳ¹���ִ�������ݡ����׷��������ݵİ���Ƭ����Ƭ�����˽��ƾ��������������������֮���໥�����ֳ���Ц�ϵİ�����£����й��ײ���������Ȧ�׷���̬�Ķ��а���Ƭ��ӰƬ��2015��12��3�����й��ڵ���ӳ��',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('����û�뵽','��С��','movies/hu.mp4','images/movies/wwmxd.png',20,0,'2013-06-10 12:23:00','������û�뵽����2015�������С��ִ�������ϲ���Ӱ���ɻƽ��¼��ƣ�����������ָ��������橡��׿͡��°��ء��������ѭ��ī�ȳ��ݡ���Ƭ������ڼΪ����������С������������ɮʦͽ�󣬷�����һϵ��ð�չ��¡�ӰƬ��2015��12��18�����й���½��ӳ��',3);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('У�����������','�⽨��','movies/hu.mp4','images/movies/xhdtsgs.png',170,0,'2014-10-16 12:23:00','��У����������֡�[1]  �Ǹ������˶���ͬ��С˵�ı࣬���⽨��ִ���������ء������¡���ܿ�硢�����ǡ�����ޱ�����ݵ��ഺ����硣',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('С���˴�����','�������Ͷ��Ƥ�������·�','movies/hu.mp4','images/movies/xhrdym.png',100,0,'2017-10-10 12:23:00','��С���˴����ȡ���һ��2015�������ϲ�綯����Ӱ����ӰƬ�ɿ������Ͷ��Ƥ�������·�ִ����ɣ����������ˡ�Ƥ�������·ҡ�ʷ�ٷ򡤿�������������������ֹ�˾�ͻ���Ӱҵ���ϳ�Ʒ����ӰƬ������С���˵���ʷ�Լ�����Ҫ�ҵ�ǿ��������ˣ������������������ҵ�Ĺ��£������漰���׶ء�ŦԼ�ȼ�������У���Ƭ��2015��9��13����3D��IMAX 3D��ʽ���й���ӳ��',5);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('Сʱ��3','������','movies/hu.mp4','images/movies/xsd3.png',99,0,'2015-10-16 12:23:00','��Сʱ��3���̽�ʱ�������ɹ�����ִ�������ݡ����ɽࡢ���𶫡������á���ѧ����л���ص����ݵ��ഺʱ�ж��е�Ӱ����Ƭ�ı��Թ�����ͬ��С˵��ӰƬ��Ҫ������������������桢�����磬�ĸ���Сһ�𳤴�ĺý��ô�ѧ��ҵ����ְ������ʼ���µ��ó̵Ĺ��¡���2014��7��17��ȫ����ӳ��',6);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�����㰮��','������','movies/hu.mp4','images/movies/yznaw.png',60,0,'2007-10-10 12:23:00','�������㰮�ҡ������������ݵ�һ�������Ը�ϲ���Ӱ����֣������һ������ݣ���2015��2��6����ӳ����Ƭ��Ҫ��̽��ŮȨ���弰Ů�����Բ��Ļ���ĵ�Ӱ��ӰƬ�������ڰ����Ը�ϲ��Ĵ�ͳģʽ����չ��������͵��й���ͥ����Ԥ���˵������������鰮�������Լ���ѡ���ϵĶ��ֿ��ܣ�ڹ���ˡ��Կ������ɣ�����������Ψһ������ʽ����ۡ�',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('̽�鵵��','��','movies/hu.mp4','images/movies/tlda.png',10,0,'2015-10-30 12:23:00','��̽�鵵����һ���ɡ���������Ƭ��ʦ����ִ�����¹�ϣ������������ǡ���濾ꡢ갽��������������Ƶ±����������ݵĴ���������������硣',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�������Ŀ���','����¶�������','movies/hu.mp4','images/movies/kbjdkr.png',180,0,'2015-11-10 12:23:00','���������Ŀ��ˡ��ǰ���¶�������ִ��������¡�����˹�����ȡ��߸��ɡ��Ű��������ݡ������������ɶ����ݵ����ɵ�Ӱ����Ƭ��2017��1��6������������ӳ����Ƭ��������ҵ�Ұ����ﰲ����ҵ��������֮ʱ������һ׮ıɱ���У�Ϊ��ϴ���������������˽���Ů��ʦ��������Ϊ�Լ��绤��',3);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('��������','���ˡ�ʩ�ε�','movies/hu.mp4','images/movies/zylm.png',125,0,'2013-11-10 12:23:00','���������ˡ��������ˡ�ʩ�ε�ִ��������˹������¡���˹��Τ�Ǳ�磬�����������ˣ���������ά�����Ƕ����Ӷ�����ݵĶ�����õ�Ӱ���ı���DC��������DC��չ����ĵ��岿ӰƬ�����·����ڡ���������ս���ˣ�����������֮����Ҫ���������һ��ȫ�µ�������в�����ˡ�������������Ů�����������������͸ֹ���λӢ�۾��ף������δ֪����в�Կ��Ĺ��¡� ��Ƭ��2017��11��16�����й��ڵز���ӰԺ��ǰ��ӳ��11��17���뱱��ͬ����ӳ��',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('ʮ�����Ц��','����','movies/hu.mp4','images/movies/swglxh.png',127,0,'2016-09-10 12:23:00','��ʮ�����Ц�����Ǹ��������Һ������Ʒ�ı�Ķ�������¬�����歽ർ�ݡ�������һ����2012��7��11�ղ�������12��������ᣬ�ڶ�����2013��12��31�տ�����',5);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('Ӣ�׶Ծ�','����������','movies/hu.mp4','images/movies/yldj.png',128,0,'2014-11-10 12:23:00','��Ӣ�׶Ծ��������й���Ӣ�����������Ķ������Ƭ������������������������ִ����������Ƥ��˹����³˹���������ݡ���Ƭ��2017��9��30�����й��ڵ���ӳ����Ӣ�׶Ծ�������ʷ�ٷҡ���ɪ1992������С˵���й��ˡ��ı࣬������������Ӣ����Խ�ϻ����������Ů���ڿֲ�Ϯ���в������ѣ�Ϊ�˸�Ů���ֻع���������̤����ֲ���֯����֮·�Ĺ��¡�',6);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('����3','�����ӡ�ά����','movies/hu.mp4','images/movies/ls3.png',170,0,'2015-10-15 12:23:00','������3������ƻ衷��Thor: Ragnar?k��������Ӱҵ��Ʒ��һ���ƻü���ö�����Ӱ��ȡ������������������ƻ衷����������Ӱ����ĵ�ʮ�߲���Ӱ���������ӡ�ά����ִ��������˹����ķ˹��˹����ķ��ϣ����˹�١����ء��������ء���ˡ�³���塢̩ɯ������ɭ�����ݡ���2017��11��3����������ӳ���й�ͬ����ӳ����Ƭ����ʧȥ������֮��������������������������һ�˵���ϵ�У����ֶ�����ͼ�ص���˹�ӵ£���ֹӵ�����������������������޴���ѡ�������Ļƻ裬�ݻٰ�˹�ӵ¼������е�������',2);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�������','�º���','movies/hu.mp4','images/movies/ndmz.png',230,1,'2013-10-15 12:23:00','��������֡��������º���ִ��������ľ¡֮�顢�ϰ�ʯ����������Ҫ������һ��ԭ���ձ�������Ӱ����Ʒ��2016��8��26�����ձ���ӳ���й��ڵ���2016��12��2����ӳ����Ʒ��������Ů��������������������Ѱ�ұ˴˵Ĺ��¡�����ʱ��2017��8��26��������й���½��PPTV��bilibili�������ա��ſ������ײ���',1);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�޼��','��ΰǿ�����׻�','movies/hu.mp4','images/movies/wjd.png',420,1,'2014-10-30 12:23:00','���޼��������ǵ�Ӱ���й�˾��2002���Ʒ��һ������Ƭ������ΰǿ�����׻�ִ�������»�������ΰ������������־ΰ�����ݡ���Ƭ��������������ݻ��ҵ����˷ֱ�Ϊ�����ͺ������Եף�����һ�����ҵĽǶ������Ǿ���ҪѰ���Լ��Ĺ��¡�2003�꣬��Ƭ����˵�22����۵�Ӱ������ѵ�Ӱ������40��̨���Ӱ�������ӰƬ�Ƚ������ΰƾ���Ƭ��õ�22����۵�Ӱ������������ǽ��Ƚ��',3);


insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('ս��','�⾩','movies/hu.mp4','images/movies/zl.png',320,1,'2015-10-10 12:23:00','��ս�ǡ������⾩ִ�����ִ�����ս��Ƭ����Ƭ���⾩�����С��ߴ�졢˹���ء�����˹ ������Ÿ�����ݡ���ӰƬ���ڹ����ײ�3D����ս����Ӱ����ʱ����ȫ�����죬��ս�ǡ���ʵ������һ������߾�ս����Ҳ�ÿ��ơ�����֮�ǡ������ֱ�ս�Ӽ�����սʿ�״ε�½����Ļ����������С����ɳ�Ϊ���ȹ��Һ��������˵Ĺµ�Ӣ�۵Ĵ�����¡���ӰƬ��2015��4��2��ȫ����ӳ��2015��6��20�գ���ս�ǡ��ڳ���������Ӱ���ϰ�������Ѷ���Ƭ����Ѷ�������Ա������ؼ�����Ѵ򶷳����������󽱡�2016��8��6�գ���20�컪�� .',4);

insert into [dbo].[movielist]([mname],[maker],[url],[img],[playtimes],[isrecommend],[onlinetime],[brief],[tid],[movies_no])
values('�����밲��','�¿���','movies/hu.mp4','images/movies/qyyas.png',220,0,'2013-09-10 12:23:00','�������밲�������ɼ���Ӱҵ����ӳӰҵ������Ͱ�Ӱҵ�������޹�˾���ϳ�Ʒ���¿������ƣ�������ִ�����ܶ��ꡢ��˼�����ݵ��ഺ�����Ӱ����Ƭ����������ɽ�����ݱ�������ͬ��С˵�ı࣬���������¡��͡�����������Ů����13�꿪ʼ��ʶ��֪���మ��ɱ�ĳɳ����¡� ��Ƭ��2016��9��14�����й���½��ӳ���ڵ�53������ϻ�����Ů���ǽ����������ѵ��ݡ���Ѹı�籾�������������ڵ�36������ϻ����ѵ�Ӱ�����Ů���ǡ���ѵ��ݡ���ѱ���12��������',5);


--��ӵ�½�û���Ϣ

insert into mH_admin values ('user1','C4CA4238A0B923820DCC509A6F7584',1); --�û���user1(Сд+����) ������md5 ���ģ�1 (����) , ��������Ա
insert into mH_admin values ('user2','C81E728D9D4C2F636F067F89CC1486',0); --�û���user2(Сд+����) ������md5 ���ģ�2 (����) , ��ͨ����Ա

--��ӹ���Ա������־��Ϣ
insert into  mH_admin_log values('wxh','192.168.3.1','2017-12-09 15:05','��¼�˺�̨����ϵͳ','��'); --0��ʾû�к���Ƶ�����Ϣ
insert into  mH_admin_log values('nxl','192.168.133.1','2017-12-09 15:05','�����һ����Ӱ','��ս�ǡ�'); --0��ʾû�к���Ƶ�����Ϣ
insert into  mH_admin_log values('user1','170.0.3.1','2017-12-11 15:05','�༭����Ƶ��Ϣ','������û�뵽��'); --0��ʾû�к���Ƶ�����Ϣ
insert into  mH_admin_log values('user1','192.112.3.1','2017-10-09 15:05','�޸��˵�¼����','��'); --0��ʾû�к���Ƶ�����Ϣ
insert into  mH_admin_log values('wxh','192.112.3.1','2017-11-09 15:45','�����һ����Ӱ','��������֡�'); --0��ʾû�к���Ƶ�����Ϣ
insert into  mH_admin_log values('nxl','127.105.3.1','2017-10-09 05:05','�޸��˵�¼����','��'); --0��ʾû�к���Ƶ�����Ϣ

select * from types --��ѯ����� �����Ϣ�Ƿ���ȫ
select * from movielist --��ѯ��Ӱ�� �����Ϣ�Ƿ���ȫ
select * from mH_admin --��ѯ��¼����Ա�� �����Ϣ�Ƿ���ȫ
select * from mH_admin_log  --��ѯ����Ա������־�� �����Ϣ�Ƿ���ȫ
