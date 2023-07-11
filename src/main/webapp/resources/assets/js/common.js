function gfn_isNull(str) {
	if (str == null) return true;
	if (str == "NaN") return true;
	if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0 ) return true;   
    return false; 
}

function ComSubmit(opt_formId) {
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.url = "";
	
	if(this.formId=="commonForm"){
		var frm = $("#commonForm");
		if(frm.length>0){
			frm.remove();
		}
		var str = "<form id='commonForm' name='commonForm'></form>";
		$('body').append(str);
	}
	
	this.setUrl = function setUrl(url){
		this.url = url;
	};
	
	this.addParam = function addParam(key, value){
		$("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
	};
	
	this.submit = function submit(){
		var frm = $("#"+this.formId)[0];
		frm.action = this.url;
		frm.method = "post";
		frm.submit();	
	};
}

var fv_ajaxCallback = "";
function ComAjax(opt_formId){
	this.url = "";		
	this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
	this.param = "";
	
	if(this.formId=="commonForm"){
		var frm = $("#commonForm");
		if(frm.length>0){
			frm.remove();
		}
		var str = "<form id='commonForm' name='commonForm'></form>";
		$('body').append(str);
	}
	
	this.setUrl = function setUrl(url){
		this.url = url;
	};
	
	this.setCallback = function setCallback(callBack){
		fv_ajaxCallback = callBack;
	};

	this.addParam = function addParam(key,value){ 
		this.param = this.param + "&" + key + "=" + value; 
	};
	
	this.ajax = function ajax(){
		if(this.formId != "commonForm"){
			this.param += "&" + $("#" + this.formId).serialize();
		}
		$.ajax({
			url : this.url,    
			type : "POST",   
			data : this.param,
			async : false, 
			success : function(data, status) {
				if(typeof(fv_ajaxCallback) == "function"){
					fv_ajaxCallback(data);
				}
				else {
					eval(fv_ajaxCallback + "(data);");
				}
			}
		});
	};
}

/*
divId : 페이징 태그가 그려질 div
pageIndx : 현재 페이지 위치가 저장될 input 태그 id
recordCount : 페이지당 레코드 수
totalCount : 전체 조회 건수 
eventName : 페이징 하단의 숫자 등의 버튼이 클릭되었을 때 호출될 함수 이름
*/

var gfv_pageIndex = null;
var gfv_eventName = null;

/* 페이징 검색 조건 및 검색 키워드 변수 선언 시작 */
var gfv_searchType = null;
var gfv_keyword = null;
var gfv_listType = null;
var gfv_category = null;
var gfv_brandType = null;
var gfv_sizeType = null;
var gfv_priceType = null;
/* 페이징 검색 조건 및 검색 키워드 변수 선언 끝 */

function gfn_renderPaging(params){
	var divId = params.divId; //페이징이 그려질 div id
	gfv_pageIndex = params.pageIndex; //현재 위치가 저장될 input 태그
	
	/* 페이징 검색 조건 및 검색 키워드 변수 초기화 시작 */
	gfv_searchType = params.searchType; //검색 조건이 저장될 input 태그
	gfv_keyword = params.keyword; //검색 키워드가 저장될 input 태그
	gfv_listType = params.listType; //전체 상품리스트에서 정렬 조건이 저장될 input 태그
	gfv_category = params.category; //전체 상품리스트에서 카테고리가 저장될 input 태그
	gfv_brandType = params.brandType; //전체 상품리스트에서 브랜드가 저장될 input 태그
	gfv_sizeType = params.sizeType; //전체 상품리스트에서 사이즈가 저장될 input 태그
	gfv_priceType = params.priceType; //전체 상품리스트에서 가격이 저장될 input 태그
	/* 페이징 검색 조건 및 검색 키워드 변수 초기화 끝 */
	
	var totalCount = params.totalCount; //전체 조회 건수
	var currentIndex = $("#"+params.pageIndex).val(); //현재 위치
	if($("#"+params.pageIndex).length == 0 || gfn_isNull(currentIndex) == true){
		currentIndex = 1;
	}
	
	var recordCount = params.recordCount; //페이지당 레코드 수
	if(gfn_isNull(recordCount) == true){
		recordCount = 10;
	}
	var totalIndexCount = Math.ceil(totalCount / recordCount); // 전체 인덱스 수
	gfv_eventName = params.eventName;
	
	$("#"+divId).empty();
	var preStr = "<nav><ul class='pagination justify-content-center'>";
	var postStr = "";
	var str = "";
	
	var first = (parseInt((currentIndex-1) / 10) * 10) + 1;
	var last = (parseInt(first+9) > parseInt(totalIndexCount)) ? parseInt(totalIndexCount) : parseInt(first+9);
	var prev = (parseInt((currentIndex-1)/10)*10) - 9 > 0 ? (parseInt((currentIndex-1)/10)*10) - 9 : 1; 
	var next = (parseInt((currentIndex-1)/10)+1) * 10 + 1 < totalIndexCount ? (parseInt((currentIndex-1)/10)+1) * 10 + 1 : totalIndexCount;
	
	if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨앞, 앞 태그 작성
		preStr += "<li class='page-item'>"
		+ "<a href='#this' class='page-link' onclick='_movePage(1)'><span>&laquo;</span></a></li>" +
				"<li class='page-item'><a href='#this' class='page-link' onclick='_movePage("+prev+")'><span>&lt;</span></a></li>";
	}
	else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨앞 태그 작성
		preStr += "<li class='page-item'>"
		+ "<a href='#this' class='page-link' onclick='_movePage(1)'><span>&laquo;</span></a></li>";
	}
	
	if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨뒤, 뒤 태그 작성
		postStr += "<li class='page-item'><a href='#this' class='page-link' onclick='_movePage("+next+")'><span>&gt;</span></a></li>" +
					"<li class='page-item'><a href='#this' class='page-link' onclick='_movePage("+totalIndexCount+")'><span>&raquo;</span></a></li>";
	}
	else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨뒤 태그 작성
		postStr += "<li class='page-item'><a href='#this' class='page-link' onclick='_movePage("+totalIndexCount+")'><span>&raquo;</span></a></li>";
	}
	
	postStr += "</ul></nav>";
	
	for(var i=first; i<=last; i++){
		if(i != currentIndex){
			str += "<li class='page-item'><a href='#this' class='page-link' onclick='_movePage("+i+")'>"+i+"</a></li>";
		}
		else{
			str += "<li class='page-item'><strong><a href='#this' class='page-link' onclick='_movePage("+i+")'>"+i+"</a></strong></li>";
		}
	}
	$("#"+divId).append(preStr + str + postStr);
}

function _movePage(value){
	$("#"+gfv_pageIndex).val(value);
	
	/* 페이징 검색 조건 및 검색 키워드 값 가져오기 시작 */
	var searchType = $("#"+gfv_searchType).val();
	var keyword = $("#"+gfv_keyword).val();
	var listType = $("#"+gfv_listType).val();
	var category = $("#"+gfv_category).val();
	var brandType = $("#"+gfv_brandType).val();
	var sizeType = $("#"+gfv_sizeType).val();
	var priceType = $("#"+gfv_priceType).val();
	/* 페이징 검색 조건 및 검색 키워드 값 가져오기 끝 */
	
	if(typeof(gfv_eventName) == "function"){
		/* 매개변수 순서에 맞게 추가하기!! */
		gfv_eventName(value, searchType, keyword, listType, category, brandType, sizeType, priceType);
	}
	else {
		/* 매개변수 순서에 맞게 추가하기!! */
		eval(gfv_eventName + "(value, searchType, keyword, listType, category, brandType, sizeType, priceType);");
	}
}