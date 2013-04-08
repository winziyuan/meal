%%%==================================================================== 
%%% File   :meda.hrl
%%% Author : my name <wangguancheng@trends.com.cn>
%%% Description : 
%%%====================================================================

-define(MEDA_RIAK_HOSTS,"127.0.0.1").
-define(MEDA_EJABBERD_HOSTS,"itrends.com").
-define(MEDA_EJABBERD_PORT,5222).
-define(MEDA_RIAK_PORT,8087).
-define(MAX_NUMBER,10).
-define(MEDA_PASSWD_BUCKET,<<"itrends/ejabberd/register/passwd">>).
-define(MEDA_CLASSIFY_BUCKET,<<"itrends/ejabberd/category">>).
-define(MEDA_CLASSIFY_KEY,"itrends/ejabberd/category/key").
-define(MEDA_USER_PERSONAL_INFORMATION_BUCKET,<<"itrends/ejabberd/user/personal/information/vcard">>).
-define(MEDA_BUCKET_AUTO_ADD_LOGO, <<"itrends/ejabberd/auto_add_logo">>).
-define(MEDA_AUTO_ADD_LOGO_KEY, "itrends/ejabberd/auto_add_logo_key").
-define(EJABBERD_COOKIE,ejabberd@meta).
-define(ADMIN_EMAIL,"iTrends_admin@trends.com.cn").  
-define(EMAIL_TITLE,"Forgot Password").



%% 统计
-define(Login_bucket,<<"itrends/ejabberd/stats/login_info">>).
-define(Loginoff_bucket,<<"itrends/ejabberd/stats/logoff_info">>).
-define(Normal_bucket,<<"itrends/ejabberd/stats/normal">>).
-define(Timelong_bucket,<<"itrends/ejabberd/stats/timelong">>).  
-define(Counter_bucket,<<"itrends/ejabberd/stats/counter">>). 
-define(Exception_bucket,<<"itrends/ejabberd/stats/exception">>). 

 
%% 自动抓到的数据
-define(MEDA_URLS_BUCKET,<<"meda/xcrawler">>).

%% 用户属性名称列表
-define(MEDA_USER_ATTRIBUTE_LIST,[nickname,title,logobinval,photobinval,telnumber,isplay,userid,createtime]).

%% 用户注册数量统计
-define(MEDA_USER_COUNT_BUCKET,<<"itrends/user/count">>).
-define(MEDA_USER_COUNT_KEY,<<"itrends/user/count/key">>).

%% 用户注册默认分配关注的杂志
-define(BUCKET_PUBSUB_AUTO_SUB_NODE, <<"itrends/ejabberd/pubsub/auto_sub_node">>).
-define(PUBSUB_AUTO_SUB_NODE_KEY, "itrends/ejabberd/pubsub/auto_sub_node_key").


%% 系统用户注册设置
-define(MEDA_USER_REGISTER_SETTING_BUCKET,<<"itrends/user/register/setting/bucket">>).
-define(MEDA_USER_REGISTER_SERRING_KEY,<<"itrends/user/register/setting/key">>).

%% 杂志管理
-define(MEDA_PUBSUB_NODE_BUCKET,<<"itrends/ejabberd/pubsub_node">>).

%% 内容管理
-define(MEDA_PUBSUB_ITEM_BUCKET,<<"itrends/ejabberd/pubsub_item">>).

%%  评论数
-define(MEDA_CONTENT_COMMENTS_COUNT_BUCKET,<<"itrends/ejabberd/comments_count">>).

%%  浏览数
-define(MEDA_CONTENT_PAGEVIEW_COUNT_BUCKET,<<"itrends/ejabberd/pub_sub_num">>).

%%  转载数
-define(MEDA_CONTENT_REPRODUCED_COUNT_BUCKET,<<"itrends/ejabberd/pubsub_item_num">>).

%% 通用配置部分
-define(MEDA_CONTENT_PUBLIC_CONFIGURATION_BUCKET,<<"itrends/ejabberd/content/public/configuration">>).  

%% version 
-define(MEDA_VERSION_BUCKET, <<"itrends/version/bucket">>).
-define(MEDA_VERSION_KEY, <<"itrends/version/key">>).

%% 礼品
-define(MEDA_GIFT_BUCKET, <<"itrends/gift">>).
-record(gift, {id, name, description, count, img_url, create_date}).
%% 礼品发放记录
-define(MEDA_GIFT_RECORD_BUCKET, <<"itrends/gift/record">>).
-record(gift_record, {id, gift_name, gift_id, user, create_date}).

-define(MEDA_CONTENT_PUBLIC_CONFIGURATION_ARTICLE_KEY,<<"itrends/ejabberd/content/public/configuration/article/key">>).
-define(MEDA_CONTENT_PUBLIC_CONFIGURATION_PIC_KEY,<<"itrends/ejabberd/content/public/configuration/pic/key">>).
-define(MEDA_CONTENT_PUBLIC_CONFIGURATION_AUDIO_KEY,<<"itrends/ejabberd/content/public/configuration/audio/key">>).
-define(MEDA_CONTENT_PUBLIC_CONFIGURATION_VIDEO_KEY,<<"itrends/ejabberd/content/public/configuration/video/key">>).
-define(MEDA_CONTENT_PUBLIC_CONFIGURATION_MAGAZINE_KEY,<<"itrends/ejabberd/content/public/configuration/magazine/key">>).

-define(MAXTITLELENGTH,"18").
-define(MAXCONTENTLENGTH,"3000").
-define(MAXIMGSIZE,"10").
-define(IMGSUFFIXLIMIT,"jpg,gif,png").
-define(IMGFUNCTION,"0").
-define(MAXAUDIOSIZE,"10").
-define(AUDIOSUFFIXLIMIT,"mp3,mp4,wma").
-define(AUDIOFUNCTION,"0").
-define(MAXVIDEOSIZE,"10").
-define(VIDEOSUFFIXLIMIT,"rmvb,mkv").
-define(VIDEOFUNCTION,"0").
-define(MAGAZINECONFIG,"0").

%% user register setting
-record(setregister,
        {register_way  =  "0",  %%注册方式
         invite_way    =  "0",  %%邀请方式
         is_activate   =  "0"   %% 是否激活
        }).


%% user passwd
 -record(passwd, {us, password,is_disabled,register_time}).

%% user vcard
-record(vcard,{nickname = "", email = "", photo = "", logo = "", title = "", telnumber = "", sex = "", role ="" }).

%% user logo setting
-record(user_logo, {name = "", 
                    url = ""}).

%% category 
-record(category,
        {id   =  "",
         name =  "",
         icon =  "",
         sort =  "",
         create_time = "",
         is_display  = ""}).

%% pubsub_node
-record(pubsub_node, 
{
    nodename,
    id,
    node,
    flatriak,
    createuser,
    icon,
    category
}).

%% pubsub_item
-record(pubsub_item,
{
  itemid,
  creation          = {'unknown','unknown'},
  modification      = {'unknown','unknown'},
  payload           = [],
  published         = "",
  node_icon         = "",
  node_name         = "",
  node_creator      = "",
  node_creator_jid  = "",
  node_creator_icon = "",
  creator           = "",
  creator_jid       = "",
  creator_icon      = "",
  category          = "",
  level             = "0"
}).

%% pubsub_item_title_content_link
-record(pubsub_item_link, 
        {
         title = "", 
         content = "" ,
         link = []
        }).

-record(pubsub_item_num,
        {
        item_id,
        reship_num = 0
        }).

-record(pub_sub_num,
        {
        usr,
        publish_num    =  0,
        subscribe_num  =  0,
        subscribed_num =  0,
        page_view_num  =  0
        }).

-record(comments_count,
        {id::{string(),string()},
        comments_count::string()
        }).

%% version
-record(version, 
        {
            name   =   "",
            createtime =  "",
            state  =  "",
            platform = "",
            filesize = 0,
            market = "",
            market_url = "",
            upload_url =  ""
        }).

