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
			fieldName : "menuName"
		}, {
			fieldName : "auth"
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
	    }];

		if (grid == grdMain)
			grid.setColumns(columns);
	}
/*	
	function loadData(provider) {
		$.ajax({
			type : "post",
			dataType : "json",
			url : "/getProducts.do",
			success : function(data){
				provider.fillJsonData(data);
			},
			error : function(xhr, status, error){
				alert(error);
			}
		});
	}
*/	
	function loadData(provider) {

		//provider.fillJsonData(json);
		//provider.setJsonData(json);
		provider.setRows(data, "treeNode", true, "", "");
		grdMain.expandAll();
	}	

	function btnInsertClickHandler(e) {
		//var curr = grdMain.getCurrent();
		//grdMain.beginInsertRow(Math.max(0, curr.itemIndex));
		//grdMain.showEditor();
		//grdMain.setFocus();
		// 최상위 노드에 행 추가
		var curr = grdMain.getCurrent();
console.log("btnInsertClickHandler curr="+curr.itemIndex);		
		dataProvider.addChildRow(
	      curr.dataRow,     // parent rowId
		  [-1, "Insert 노드"]
		);		
		
		
		
	}

	function btnAppendClickHandler(e) {
		/*
		grdMain.beginAppendRow();
		grdMain.showEditor();
		grdMain.setFocus();
		*/
		// 최상위 노드에 행 추가
        var curr = grdMain.getCurrent();
console.log("btnAppendClickHandler curr="+curr.itemIndex);		
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
</body>
</html>