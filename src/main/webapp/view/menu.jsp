<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RealGrid Tree Sample Page</title>
<style type="text/css">
span {
	font-size: 30px;
	font-weight: 900;
}

.title {
	margin-top: 20px;
	margin-bottom: 20px;
}
</style>

<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/realgridjs-lic.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jszip.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/realgridjs_eval.1.1.43.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/realgridjs-api.1.1.43.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- 
https://demo.realgrid.com/Tree/TreeEditing/ 참조
 -->
<script type="text/javascript">
var data = [
			["0", "\\", "Y"],
			["0.001", "영업관리", "Y"],
			["0.001.001", "영업관리1-중분류", "Y"],
			["0.001.001.001", "영업관리1-소분류1", "Y"],
			["0.001.001.002", "영업관리1-소분류2", "Y"],
			["0.001.001.003", "영업관리1-소분류3", "Y"],
			["0.002", "영업회계", "Y"],
			["0.002.001", "영업회계1-중분류", "Y"],
			["0.002.001.001", "영업회계1-소분류1", "Y"],
			["0.002.001.002", "영업회계1-소분류2", "Y"],
			["0.002.002", "영업회계2-중분류", "Y"],
			["0.002.002.001", "영업회계2-소분류1", "Y"],
			["0.002.002.002", "영업회계2-소분류2", "Y"],
			["0.002.002.003", "영업회계2-소분류3", "Y"],
			["0.002.002.004", "영업회계2-소분류4", "Y"]
];

	$(function() {
		$("#btnInsert").click(btnInsertClickHandler);
		$("#btnAppend").click(btnAppendClickHandler);
		$("#btnDelete").click(btnDeleteClickHandler);
		$("#btnSaveData").click(btnSaveDataClickHandler);
		$("#btnSaveAllData").click(btnSaveAllDataClickHandler);
		$("#btnGetRowData").click(btnGetRowDataClickHandler);
		$("#btnSearchData").click(btnSearchDataClickHandler);
		setupGridJs("grdMain", "100%", "300");
		
	});

	var grdMain;
	var dataProvider;
	
	function setupGridJs(id, width, height) {
		$("#"+id).css({ width : width, height : height });
		grdMain = new RealGridJS.TreeView(id);
		dataProvider = new RealGridJS.LocalTreeDataProvider();
		grdMain.setDataSource(dataProvider);
		
		setFields(dataProvider);
		setColumns(grdMain);
		setOption(grdMain);
		
		loadData(dataProvider);
	};
	
	function setOption(grid) {
		grid.setOptions({
			edit : {
				insertable : true,
				editable : true,
				appendable : true,
				deletable : true,
				deleteRowsConfirm : true,
				deleteRowsMessage : "Are you sure?"
			}
		});

		dataProvider.setOptions({
			softDeleting : false
		});
	}
	
	function setFields(provider) {
		var fields = [ {
			fieldName : "treeNode"
		}, {
			fieldName : "treeNodeParent"			
		}, {
			fieldName : "menuName"
		}, {
			fieldName : "auth"
		}, {
			fieldName : "menuLevel"			
		}, {
			fieldName : "orderNo"
		}];

		if (provider == dataProvider)
			provider.setFields(fields);
	}

	function setColumns(grid) {
	    var columns = [{
	        "name": "menuName",
	        "fieldName": "menuName",
	        "width": 350,
	        "header": {
	            "text": "메뉴명"
	        }       
	    }, {
	        "name": "auth",
	        "fieldName": "auth",
	        "width": 150,
	        "header": {
	            "text": "권한여부"
	        },
	        "editable": false,
	        "renderer": {
	            "type": "check",
	            "shape": "box",
	            "editable": true,
	            "startEditOnClick": true,
	            "trueValues": "Y",
	            "falseValues": "N"
	        }
	    }, {
	        "name": "menuLevel",
	        "fieldName": "menuLevel",
	        "width": 50,
	        "header": {
	            "text": "레벨"
	        },
        	"editable": true,
        	"startEditOnClick": true      
	    }, {
	        "name": "orderNo",
	        "fieldName": "orderNo",
	        "width": 50,
	        "header": {
	            "text": "순번"
	        },
        	"editable": true,
        	"startEditOnClick": true	        
	    }];

		if (grid == grdMain)
			grid.setColumns(columns);
	}
	
	function loadData(provider) {
		$.ajax({
			type : "post",
			dataType : "json",
			url : "/getMenuList.do",
			success : function(data){
				//provider.fillJsonData(data);
				provider.setRows(data, "treeNode", true, "", "");
				grdMain.expandAll();
			},
			error : function(xhr, status, error){
				alert(error);
			}
		});
	}
/*	
	function loadData(provider) {

		//provider.fillJsonData(json);
		//provider.setJsonData(json);
		provider.setRows(data, "treeNode", true, "", "");
		grdMain.expandAll();
	}	
*/
	function findMinAndMax(numbers) {

	  // 배열이 비어있는 경우 null 반환
	  if (numbers.length === 0) {
	    return null;
	  }

	  // 숫자 배열 정렬
	  numbers.sort(function(a, b) {
	    return a - b;
	  });

	  // 최소값과 최대값 리턴
	  return {
	    min: numbers[0],
	    max: numbers[numbers.length - 1]
	  };
	}

	function btnInsertClickHandler(e) {
		//var curr = grdMain.getCurrent();
		//grdMain.beginInsertRow(Math.max(0, curr.itemIndex));
		//grdMain.showEditor();
		//grdMain.setFocus();
		// 최상위 노드에 행 추가
		var setOrderNo;
		var setMenuLevel;
		var curr = grdMain.getCurrent();
		var currTreeNodeParent = dataProvider.getValue(curr.dataRow, 'treeNodeParent');
		var currMenulvl = dataProvider.getValue(curr.dataRow, 'menulevel');
		if(currMenulvl==4) {return;}
		if(currTreeNodeParent==null|| currTreeNodeParent=="") {return;}

console.log("currTreeNodeParent = "+currTreeNodeParent);
console.log("btnInsertClickHandler curr="+curr.itemIndex);	
//console.log("자식 IDS::dataProvider.getDescendants="+dataProvider.getDescendants(curr.dataRow));
		var childNo = dataProvider.getDescendants(curr.dataRow);
console.log('childNo : '+childNo);		
		if(childNo==null) {return;}
		var result = findMinAndMax(childNo);
console.log('result.min : '+result.min);
console.log('result.max : '+result.max);
		// 해당 자손의 orderNo 값 조회.
		var lastLvlNo = dataProvider.getValue(result.max, 'menuLevel');
		var lastNo = dataProvider.getValue(result.max, 'orderNo');
console.log('lastLvlNo : '+lastLvlNo);	
console.log('orderNo : '+lastNo);
        // row 추가.
		dataProvider.addChildRow(
		   curr.dataRow,     // parent rowId
		   //[{"menuName":"Insert 노드","menulevel":lastLvlNo,"orderNo":lastNo}]
		   ['menuName',"Insert 노드"]
		);
		grdMain.setFocus();		
		
		
/*
		$.ajax({
			type : "post",
			dataType : "json",
			url : "/getLastOrderNo.do",
			data : {'treeNodeParent':currTreeNodeParent},
			success : function(data){
				console.log(JSON.stringify(data));
				setOrderNo = data.orderNo;
				setMenuLevel = data.menuLevel;
				console.log(">>> setOrderNo : " + setOrderNo);
				console.log(">>> setMenuLevel : " + setMenuLevel);				
				
				dataProvider.addChildRow(
		          curr.dataRow,     // parent rowId
				  ["menuName","Append 노드"]
                );
			    grdMain.setFocus();				
			},
			error : function(xhr, status, error){
				alert(error);
			}
		});
*/		
		//[{"menuName":"Append 노드","menuLevel":lastLvlNo,"orderNo":lastNo+1}]		
		
		
	}

	function btnAppendClickHandler(e) {
		/*
		grdMain.beginAppendRow();
		grdMain.showEditor();
		grdMain.setFocus();
		*/
		// 최상위 노드에 행 추가
		var setOrderNo;
		var setMenuLevel;		
        var curr = grdMain.getCurrent();
		var currTreeNodeParent = dataProvider.getValue(curr.dataRow, 'treeNodeParent');
		var currMenulvl = dataProvider.getValue(curr.dataRow, 'menulevel');
		if(currMenulvl==4) {return;}
		if(currTreeNodeParent==null|| currTreeNodeParent=="") {return;}

console.log("currTreeNodeParent = "+currTreeNodeParent);
console.log("btnAppendClickHandler curr="+curr.itemIndex);
	    // 조회.
/*
		$.ajax({
			type : "post",
			dataType : "json",
			url : "/getLastOrderNo.do",
			data : {'treeNodeParent':currTreeNodeParent},
			success : function(data){
				console.log(JSON.stringify(data));
				setOrderNo = data.orderNo;
				setMenuLevel = data.menuLevel;
				console.log(">>> setOrderNo : " + setOrderNo);
				console.log(">>> setMenuLevel : " + setMenuLevel);				
				
				dataProvider.addChildRow(
		          curr.dataRow,     // parent rowId
				  ["menuName","Append 노드"]
                );
			    grdMain.setFocus();				
			},
			error : function(xhr, status, error){
				alert(error);
			}
		});
*/	    
	    
		dataProvider.addChildRow(
		          curr.dataRow,     // parent rowId
				  ["menuName","Append 노드"]
              );
			    grdMain.setFocus();		    
	    
	}
	
	function btnDeleteClickHandler(e) {
		var curr = grdMain.getCurrent();
		dataProvider.removeRow(curr.dataRow);
		//grdMain.beginDeleteRow();
		//grdMain.showEditor();
		grdMain.setFocus();	
		
	}	

	function btnSaveDataClickHandler(e) {
		grdMain.commit();

		var currRow = grdMain.getCurrent().dataRow;
		if (currRow < 0)
			return;

		var currState = dataProvider.getRowState(currRow);
console.log(">>> currState = " + currState);		
		if (currState == "created") {
			saveData("/insertMenu.do");
		} else if (currState == "updated") {
			saveData("/updateMenu.do");
		} else if (currState == "deleted") {
			saveData("/deleteMenu.do");
		}
	}
	
	function saveData(urlStr) {
		var jRowData = dataProvider.getJsonRow(grdMain.getCurrent().dataRow);
console.log(">>> jRowData = " + JSON.stringify(jRowData));		

		$.post(urlStr, jRowData, function(data) {
			if (data > 0) {
				alert("저장 성공");
				dataProvider.clearRowStates(true);
			} else {
				alert("저장 실패!");
			}
		});
	}
	

	function btnSaveAllDataClickHandler(e) {
		grdMain.commit();

		savadataAll("/allSaveMenu.do");
	}

	function savadataAll(urlStr) {
		var state;
		var jData;
		var jRowsData = [];

		var rows = dataProvider.getAllStateRows();

		if (rows.updated.length > 0) {
			$.each(rows.updated, function(k, v) {
				jData = dataProvider.getJsonRow(v);
				jData.state = "updated";
				jRowsData.push(jData);
			});
		}

		if (rows.deleted.length > 0) {
			$.each(rows.deleted, function(k, v) {
				jData = dataProvider.getJsonRow(v);
				jData.state = "deleted";
				jRowsData.push(jData);
			});
		}

		if (rows.created.length > 0) {
			$.each(rows.created, function(k, v) {
				jData = dataProvider.getJsonRow(v);
				jData.state = "created";
				jRowsData.push(jData);
			});
		}

		if (jRowsData.length == 0) {
			dataProvider.clearRowStates(true);
			return;
		}

		$.ajax({
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			url : urlStr,
			type : "post",
			data : JSON.stringify(jRowsData),
			dataType : "json",
			success : function(data) {
				if (data > 0) {
					alert("저장 성공!");
					dataProvider.clearRowStates(true);
				} else {
					alert("저장 실패!");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	
	function btnGetRowDataClickHandler(e) {
		var currRow = grdMain.getCurrent().dataRow;
		//var currItemIdx = grdMain.getCurrent().itemIndex;
		if (currRow < 0)
			return;
console.log("getCurrent : " + JSON.stringify(grdMain.getCurrent()));		
console.log("currRow : " + currRow);		
console.log("dataProvider.getValue : " + dataProvider.getValues(currRow));
        var currMenuNm = dataProvider.getValue(currRow, 'menuName');
		var currLvl = dataProvider.getValue(currRow, 'menuLevel');
		var currNo = dataProvider.getValue(currRow, 'orderNo');
console.log("currMenuNm : " + currMenuNm);		
console.log("currLvl : " + currLvl);
console.log("currNo : " + currNo);

        var rowIds = dataProvider.getAncestors(currRow);
        if(!rowIds.length) return;
console.log(">>> 부모 rowIds : " + rowIds);        
        

	}
	//https://docs.realgrid.com/guides/crud/get-values#gsc.tab=0 참고.
	//http://help.realgrid.com/tutorial/b9-5/ <= 자식 조회.
	function btnSearchDataClickHandler() {
		var searchData = "0.001.001.003";
		// 최상위 부모 id
		var parentIds = dataProvider.getChildren(-1);
console.log(">>> parentIds : " + parentIds);
		
		for (var i in parentIds) {
			var descendantIds = dataProvider.getDescendants(parentIds[i]);
			
			//var fldLvlData = dataProvider.getValue(descendantIds[i], 'menulvl');
			//var fldNoData = dataProvider.getValue(descendantIds[i], 'orderNo');
			var fldNameData = dataProvider.getValue(descendantIds[i], 'menuName');
			
			//if (currLvl == fldLvlData && currNo == fldNoData) {
            if (searchData == fldNameData) {				
				var ancestorIds = dataProvider.getAncestors(descendantIds[i]);
console.log(">>> ancestorIds.length : " + ancestorIds.length);				
				
                for(var k = ancestorIds.length - 1 ; k >= 0 ; k--) {
                	console.log(">>> ancestorIds : " + ancestorIds[k]);                	
                    var itemIndex = grdMain.getItemIndex[ancestorIds[k]];
					console.log(">>> intemIndex : " + itemIndex);                 
                } 				
			}
		}
		
	}
		
	function btnGetAncestors(){
		var curDataRow = grdMain.getCurrent().dataRow;
		var rowIds = dataProvider.getAncestors(curDataRow);
		if(!rowIds.length) rowIds = "부모가 없는 행입니다.";
		alert(rowIds);
	}		
	
</script>
</head>
<body>
	<div class="title">
		<span>RealGrid on Java Spring MVC and SQLServer</span>
	</div>
	
	<div id="grdMain"></div>
	
	<input type="button" id="btnInsert" value="Insert Row" />
	<input type="button" id="btnAppend" value="Append Row" />
	<input type="button" id="btnDelete" value="Delete Row" />
	<input type="button" id="btnSaveData" value="Save Data" />
	<input type="button" id="btnSaveAllData" value="Save All Data" />
	<input type="button" id="btnGetRowData" value="getRowData" />
	<input type="button" id="btnSearchData" value="getSearchData" />
</body>
</html>