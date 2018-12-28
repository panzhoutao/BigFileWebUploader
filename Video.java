package com.dbdx.servlet;

import java.io.File;

import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class Video extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doGet(request, response);
		doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String savePath = this.getServletConfig().getServletContext()
                .getRealPath("");
        String folad = "uploads";
        savePath = savePath + "\\"+folad+"\\";
        
		String action = request.getParameter("action");
		
		if(action.equals("mergeChunks")){
			//合并文件
			//需要合并的文件的目录标记
			String fileMd5 = request.getParameter("fileMd5");
			
			//读取目录里的所有文件
			File f = new File(savePath+"/"+fileMd5);
			File[] fileArray = f.listFiles(new FileFilter(){
				//排除目录只要文件
				@Override
				public boolean accept(File pathname) {
					// TODO Auto-generated method stub
					if(pathname.isDirectory()){
						return false;
					}
					return true;
				}
			});
			
			//转成集合，便于排序
			List<File> fileList = new ArrayList<File>(Arrays.asList(fileArray));
			Collections.sort(fileList,new Comparator<File>() {
				@Override
				public int compare(File o1, File o2) {
					// TODO Auto-generated method stub
					if(Integer.parseInt(o1.getName()) < Integer.parseInt(o2.getName())){
						return -1;
					}
					return 1;
				}
			});
			//UUID.randomUUID().toString()-->随机名
			File outputFile = new File(savePath+"/"+fileMd5+".mp4");
			//创建文件
			outputFile.createNewFile();
			//输出流
			FileChannel outChnnel = new FileOutputStream(outputFile).getChannel();
			//合并
			FileChannel inChannel;
			for(File file : fileList){
				inChannel = new FileInputStream(file).getChannel();
				inChannel.transferTo(0, inChannel.size(), outChnnel);
				inChannel.close();
				//删除分片
				file.delete();
			}
			outChnnel.close();
			//清除文件夹
			File tempFile = new File(savePath+"/"+fileMd5);
			if(tempFile.isDirectory() && tempFile.exists()){
				tempFile.delete();
			}
			System.out.println("合并成功");
		}else if(action.equals("checkChunk")){
			//检查当前分块是否上传成功
			String fileMd5 = request.getParameter("fileMd5");
			String chunk = request.getParameter("chunk");
			String chunkSize = request.getParameter("chunkSize");
			
			File checkFile = new File(savePath+"/"+fileMd5+"/"+chunk);
			
			response.setContentType("text/html;charset=utf-8");
			//检查文件是否存在，且大小是否一致
			if(checkFile.exists() && checkFile.length()==Integer.parseInt(chunkSize)){
				//上传过
				response.getWriter().write("{\"ifExist\":1}");
			}else{
				//没有上传过
				response.getWriter().write("{\"ifExist\":0}");
			}
		}
		
	}

}
