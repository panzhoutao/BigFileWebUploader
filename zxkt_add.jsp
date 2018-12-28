<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript">
	function on(){
		var title = $('#title').val();
		var introduce = $('#introduce').val();
		var pic = $('#pic').attr("src");
		var video = $('#item1').attr("src");
		var mark = $('input[name="name.name2"]:checked').val();
		var type = $('#type').val();
		if(!pic){
			alert("请上传封面图片！");
			return;
		}
		if(!title){
			alert("请输入标题！");
			return;
		}
		if(!mark){
			alert("请选择是否推荐！");
			return;
		}
		if(!video){
			alert("请上传视频！");
			return;
		}
		if(!introduce){
			alert("请输入介绍！");
			return;
		}
		if(!type){
			alert("请选择类型！");
			return;
		}
		
		$.ajax({
       url:'<%=basePath%>admin/zxktAdd',   //请求的url地址
		data:{'title':title,
       	  'pic':pic ,
       	  'introduce':introduce ,
       	  'mark':mark,
       	  'video':video,
       	  'type':type
			},
       dataType:"json",   //返回格式为json
       type:"POST",   //请求方式
        success:function(data){
			       	if(data.status == 0){
			       		alert("添加失败");
			       	}else if(data.status==1){
			       	alert("添加成功");
			       		 window.location.href = '<%=basePath%>admin/zxkt';
			       	}
		        }
    	});
	}
</script>

<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
     <title>东北大学校友会后台管理</title>
    <link href="styles/global.css" rel="stylesheet" type="text/css">
    <script src="scripts/jquery-1.8.3.min.js"  type="text/javascript"></script>
    <script src="scripts/common.js"  type="text/javascript"></script>
    <!--[if lt IE 9]>
        <script src="scripts/IE.js" type="text/javascript"></script>
    <![endif]-->
    <!-- 上传 -->
    <link rel="stylesheet" type="text/css" href="scripts/uploadify/uploadify.css"/>
    <script type="text/javascript" src="scripts/uploadify/jquery.uploadify.min.js"></script>
    <!-- 下拉插件 -->
    <link rel="stylesheet" type="text/css" href="scripts/selectbox/jquery.selectbox.css"/>
    <script type="text/javascript" src="scripts/selectbox/jquery.selectbox-0.2.min.js"></script>
   	<!-- 时间控件 -->
    <script type="text/javascript" src="<%=basePath%>/scripts/My97DatePicker/WdatePicker.js"></script>
    <link href="<%=basePath%>/scripts/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
    <!--引入webuploader的CSS-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/scripts/webuploader-0.1.5/webuploader.css">
	<!--引入webuploader的JS-->
	<script type="text/javascript" src="<%=basePath%>/scripts/webuploader-0.1.5/webuploader.js"></script>

  </head>
  
  <body>
   	 <jsp:include page="../../publish/title.jsp" flush="true"></jsp:include> 
     <jsp:include page="../../publish/mooc_left.jsp"></jsp:include>
     
     <div id="content">
            <div class="contentbody">
                <div class="Grid">
                    <div class="section">
                        <div class="hd">
                            <h2>添加视频</h2>
                        </div>
                        <div class="bd">
                        	<form action="<%=basePath%>admin/zxktAdd" id= "submit">
                        	<div class="row">
                                <div class="col">
                                    <div class="tit">标&nbsp;&nbsp;&nbsp;&nbsp;题：</div>
                                    <div class="field">
                                        <div class="inpbox">
                                            <input type="text" id="title">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="tit">类&nbsp;&nbsp;&nbsp;&nbsp;型 ：</div>
                                    <div class="field">
                                        <div class="selectBox">
                                            <select class="select" id="type">
                                            		<option value="0">在线课堂</option>
                                            		<option value="1">掌上课堂 </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="tit">上传封面图片：</div>
                                    <div class="field">
                                        <div class="headImg">
                                            <div class="img" id="img_div">
                                            	<img src="images/headImg.png" alt="" id="pic">
                                            </div>
                                            <a class="upbtn" id="file_upload" href="#">[添加头像]</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="tit">上传文件：</div>
                                    <div class="field">
                                        <div class="headImg">
                                            <div class="img">
                                            	<img src="images/videoImg.png" alt="">
                                            </div>
                                            <a class="upbtn" id="add_video">[添加视频]</a>
                                            <div id="item1" src="">
                                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="tit">介&nbsp;&nbsp;&nbsp;&nbsp;绍 ：</div>
                                    <div class="field">
                                        <div class="textareaBox">
                                            <textarea name="content" id="introduce"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="tit">是否推荐：&nbsp;</div>
                                    <div class="field">
                                           
                                         <label class="iCheck">
                                            <input type="radio" class="beautifyradio" name="name.name2" value="1" datatype="*">
                                            <img src="images/radio_off.png" alt="" for="name.name2"/>&ensp;是
                                        </label>
                                        <label class="iCheck">
                                            <input type="radio" class="beautifyradio" name="name.name2" value="0">
                                            <img src="images/radio_off.png" alt="" for="name.name2"/>&ensp;否
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="btns">
                                <a class="confirm" onclick="on()">确定</a>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>  
            </div>
        </div>
    </div>
    <div id="footer">
        <p>版权所有：东北大学校友会</p>
    </div>

    <script type="text/javascript">
        $(function(){
            $(".select").selectbox();
            
            $('#file_upload').uploadify({
                'swf'           : '<%=basePath%>scripts/uploadify/uploadify.swf',
                'uploader'      : '<%=basePath%>Upload',
                  'folder'		: '<%=basePath%>uploads',
                'buttonText'    : '[上传图片]',
                'width'         : '66',
                'height'        : '22',
                'buttonCursor'  : 'hand',
                'onUploadSuccess': function(file, data, response) {
                 					alert("上传成功");
                 					var path = "uploads/"+data;
                 						$('#img_div').attr("class","slideimg");
                 						$("#pic").attr("src",path);
        							}
            });
        });
        
        var fileMd5;
        //监听分块上传过程中的三个时间点
        WebUploader.Uploader.register({
        	"before-send-file":"beforeSendFile",
        	"before-send":"beforeSend",
        	"after-send-file":"afterSendFile",
        },{
        	//时间点1：所有分块进行上传之前调用此函数
        	beforeSendFile:function(file){
        		var deferred = WebUploader.Deferred();
        		//1、计算文件的唯一标记，用于断点续传
        		(new WebUploader.Uploader()).md5File(file,0,10*1024*1024)
        			.progress(function(percentage){
        				$('#item1').find("p.state").text("正在读取文件信息...");
        			})
        			.then(function(val){
        				fileMd5=val;
        				$('#item1').find("p.state").text("成功获取文件信息...");
        				//获取文件信息后进入下一步
        				deferred.resolve();
        			});
        		return deferred.promise();
        	},
        	//时间点2：如果有分块上传，则每个分块上传之前调用此函数
        	beforeSend:function(block){
        		var deferred = WebUploader.Deferred();
        		
        		$.ajax({
        			type:"POST",
        			url:"<%=basePath%>Video?action=checkChunk",
        			data:{
        				//文件唯一标记
        				fileMd5:fileMd5,
        				//当前分块下标
        				chunk:block.chunk,
        				//当前分块大小
        				chunkSize:block.end-block.start
        			},
        			dataType:"json",
        			success:function(response){
        				if(response.ifExist){
        					//分块存在，跳过
        					deferred.reject();
        				}else{
        					//分块不存在或不完整，重新发送该分块内容
        					deferred.resolve();
        				}
        			}
        		});
        		
        		this.owner.options.formData.fileMd5 = fileMd5;
        		deferred.resolve();
        		return deferred.promise();
        	},
        	//时间点3：所有分块上传成功后调用此函数
        	afterSendFile:function(){
        		//如果分块上传成功，则通知后台合并分块
        		$.ajax({
        			type:"POST",
        			url:"<%=basePath%>Video?action=mergeChunks",
        			data:{
        				fileMd5:fileMd5,
        			},
        			success:function(response){
        				alert("上传成功");
                 		var path = "uploads/"+fileMd5+".mp4";
                 		$("#item1").attr("src",path);
        			}
        		});
        	}
        });
        
        var uploader = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>scripts/webuploader-0.1.5/Uploader.swf',
		    // 文件接收服务端。
		    server: '<%=basePath%>UploadVideo',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: {id: '#add_video',
		    multiple:false},
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: true,
		    auto:true,
		    //开启分片上传
		    chunked: true,
		    chunkSize:10*1024*1024,
		    
		    accept: {
		    //限制上传文件为MP4
            	extensions: 'mp4',
            	mimeTypes: 'video/mp4',
        	}
		});
		        
        // 当有文件被添加进队列的时候
		uploader.on( 'fileQueued', function( file ) {
			
			$('#item1').empty();
		    $('#item1').html('<div id="' + file.id + '" class="item">'+
		    	'<a class="upbtn" id="btn" onclick="stop()">[取消上传]</a>'+
		    	'<p class="info">' + file.name + '</p>' +
		        '<p class="state">等待上传...</p></div>'
		    );
		});
		
		// 文件上传过程中创建进度条实时显示。
		uploader.on( 'uploadProgress', function( file, percentage ) {
		    $('#item1').find('p.state').text('上传中 '+Math.round(percentage * 100) + '%');
		});
		
		uploader.on( 'uploadSuccess', function( file ) {
		    $( '#'+file.id ).find('p.state').text('已上传');
		});
		
		uploader.on( 'uploadError', function( file ) {
		    $( '#'+file.id ).find('p.state').text('上传出错');
		});
		
		uploader.on( 'uploadComplete', function( file ) {
		    $( '#'+file.id ).find('.progress').fadeOut();
		});
      
      	function start(){
			uploader.upload();
			$('#btn').attr("onclick","stop()");
			$('#btn').text("取消上传");
		}
		
		function stop(){
			uploader.stop(true);
			$('#btn').attr("onclick","start()");
			$('#btn').text("继续上传");
		}
        
    </script>
     
     
  </body>
</html>
