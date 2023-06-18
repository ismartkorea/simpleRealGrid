<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RealGrid Sample Page</title>
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

<script type="text/javascript" src="/scripts/realgridjs-lic.js"></script>
<script type="text/javascript" src="/scripts/jszip.min.js"></script>
<script type="text/javascript" src="/scripts/realgridjs_eval.1.1.43.min.js"></script>
<script type="text/javascript" src="/scripts/realgridjs-api.1.1.43.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

<script type="text/javascript">
	$(function() {
		$("#btnInsert").click(btnInsertClickHandler);
		$("#btnAppend").click(btnAppendClickHandler);
		$("#btnSaveData").click(btnSaveDataClickHandler);
		$("#btnSaveAllData").click(btnSaveAllDataClickHandler);
		setupGridJs("grdMain", "100%", "300");
	});

	var grdMain;
	var dataProvider;
	
	function setupGridJs(id, width, height) {
		$("#"+id).css({ width : width, height : height });
		grdMain = new RealGridJS.GridView(id);
		dataProvider = new RealGridJS.LocalDataProvider();
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
			softDeleting : true
		});
	}
	
	function setFields(provider) {
		var fields = [ {
			fieldName : "code"
		}, {
			fieldName : "productName"
		}, {
			fieldName : "volumne"
		}, {
			fieldName : "unit"
		}, {
			fieldName : "price",
			dataType : "number"
		} ];

		if (provider == dataProvider)
			provider.setFields(fields);
	}

	function setColumns(grid) {
		var columns = [ {
			fieldName : "code",
			width : 80,
			header : {
				text : "코드"
			},
			styles : {
				textAlignment : "near"
			}
		}, {
			fieldName : "productName",
			width : 80,
			header : {
				text : "제품명"
			},
			styles : {
				textAlignment : "near"
			}
		}, {
			fieldName : "volumne",
			width : 80,
			header : {
				text : "용량"
			},
			styles : {
				textAlignment : "near"
			}
		}, {
			fieldName : "unit",
			width : 80,
			header : {
				text : "단위"
			},
			styles : {
				textAlignment : "near"
			}
		}, {
			fieldName : "price",
			width : 80,
			header : {
				text : "단가"
			},
			styles : {
				textAlignment : "far"
			}
		} ];

		if (grid == grdMain)
			grid.setColumns(columns);
	}
	
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

	function btnInsertClickHandler(e) {
		var curr = grdMain.getCurrent();
		grdMain.beginInsertRow(Math.max(0, curr.itemIndex));
		grdMain.showEditor();
		grdMain.setFocus();
	}

	function btnAppendClickHandler(e) {
		grdMain.beginAppendRow();
		grdMain.showEditor();
		grdMain.setFocus();
	}

	function btnSaveDataClickHandler(e) {
		grdMain.commit();

		var currRow = grdMain.getCurrent().dataRow;
		if (currRow < 0)
			return;

		var currState = dataProvider.getRowState(currRow);
		if (currState == "created") {
			saveData("/insertProducts.do");
		} else if (currState == "updated") {
			saveData("/updateProducts.do");
		} else if (currState == "deleted") {
			saveData("/deleteProducts.do");
		}
	}
	
	function saveData(urlStr) {
		var jRowData = dataProvider.getJsonRow(grdMain.getCurrent().dataRow);

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

		savadataAll("/allSaveProducts.do");
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
	<input type="button" id="btnSaveData" value="Save Data" />
	<input type="button" id="btnSaveAllData" value="Save All Data" />
</body>
</html>