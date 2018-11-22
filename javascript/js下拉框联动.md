                <td align="right" width="40%">故障通道：</td>
		<td align="left">
		<select name="faultchannel" id="faultchannel" style="width:200px;" onChange="check1(this.value);" >
                </select> 
		</td>
    		<tr>
		<td align="right" width="40%">目标通道：</td>
	      	<td align="left">
		<select name="targetchannel" id="targerchannel" style="width:200px;" onChange="check3(this.value)"> 
                </select> 
		</td>
		</tr>
		<tr align="center">
		<td align="right">运营商：</td>
		<td align="left">
		<select name="type" id="type" style="width:200px;">
		</select> 
		</td>
		</tr>

html  代码
----------------------------------------------------------------------------------------------------------------------------------------
js    代码


//初始化传入的后台数据，在点击进入页面的时候，装载在第一个下拉框中	
	
	
	window.onload =function()
	{
 	  document.getElementById("faultchannel").length=0;
 	  var two = document.getElementById('faultchannel');
  	  var list=${channelList};
  	  var bb = eval(${channelList});
	  var  hashname=[];
 	  for(var i in bb) {
   		hashname.push(bb[i].ChannelName);
		}		
     	  	 for (var n = 0; n < hashname.length; n++) { //遍历生产option选项 	        	
		 var op = new Option(hashname[n],n);//创建一个option 把数据存储在option中              
            	 for(var i in bb) {
   		 if(hashname[n]==bb[i].ChannelName){
   		 op.value=bb[i].Channel;
   		 two.add(op);
   		 }
	         }		
        	 };
		 }
		 
		 
//将后台数据，去重，一一对应存入下一个联动的下拉框option组中
	
	function check1(option)
	{
	var  list=${channelList};
	var  bb = eval(${channelList});
	document.getElementById("targerchannel").length=0;
	document.getElementById("type").length=0;
	var faultchannel=new Array();
	var  list=${sqlList};
	var aa = eval(${sqlList});
	for(var i in aa) {
   	if(option==aa[i].Source){
   		//console.log(aa[i].Target);
   		faultchannel.push(aa[i].Target);
   	}
	}	
	var   hash=[];//console.log(faultchannel);去重
	faultchannel.sort();
	for(var i=0;i<faultchannel.length;i++){
	if(faultchannel[i]!==hash[hash.length-1]){
	hash.push(faultchannel[i]);
	}
	}
 	 var  hashname=[];	//console.log(hash);
 	 hashname.push("请选择");
 	 for(var n=0;n<hash.length;n++){
 	 for(var i in bb) {
   		if(hash[n]==bb[i].Channel){
   		//console.log(aa[i].Target);
   		hashname.push(bb[i].ChannelName);
   	}
	}
	}	
 	var two = document.getElementById('targerchannel');
 	two.length=0; 
        for (var n = 0; n < hashname.length; n++) { //遍历生产option选项
     	    var op = new Option(hashname[n],n); //创建一个option 把数据存储在option
            for(var i in bb) {
   			if(hashname[n]==bb[i].ChannelName){
   			op.value=bb[i].Channel;
   			two.add(op);
   		}
		}		
        };
	}


//最后一个下拉框填充
		
		
 	function check3(option)
	{	
	document.getElementById("type").length=0;
	var two = document.getElementById('faultchannel').value;
	var flag=new Array();
	var list=${sqlList};
	var aa = eval(${sqlList});
	for(var i in aa) {
   	if(two==aa[i].Source && option==aa[i].Target){
   		//faultchannel.push(aa[i].Target);//根据source通道和目标通道，筛选出list中存在的flag，代表三个运营商和全部
   		//console.log(aa[i].Flag);
   		flag.push(aa[i].Flag);  		
   	}
	}
 	//console.log(hash);
 	var  hashname=[];
 	hashname.push("请选择");
 	for(var i=0;i<flag.length;i++){
	if(flag[i]=="1"){
		hashname.push("联通");
	}else if(flag[i]=="2"){
		hashname.push("移动");
	}else if(flag[i]=="3"){
		hashname.push("电信");
	}else if(flag[i]=="4"){
		hashname.push("全部");
	}else{
	}
	}
 	 // console.log(hashname);	 
 	var type = document.getElementById('type');
        for (var i = 0; i < hashname.length; i++) { //遍历生产option选项 
            var op = new Option(hashname[i],i);	//创建一个option 把数据存储在option 		
		if(hashname[i]=="联通"){
		op.value="1";
		}else if(hashname[i]=="移动"){
		op.value="2";
		}else if(hashname[i]=="电信"){
		op.value="3";			
		}else if(hashname[i]=="全部"){
		op.value="4";			
		}else if(hashname[i]=="请选择"){
		op.value="0";
		}
		else{
		}
            type.add(op);//把带有数据的option 添加到第二个select
        };
	}		
