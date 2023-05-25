<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<style>
.btn_updel {
	width: 110px;
	height: 40px;
	background-color: #693FAA;
	color: #fff;
	border-radius: 100px;
	border-style: none;
}
.deal-type{
border: none;
}
</style>
<script>

let latitude = ${bag.directAddressx};
let longitude = ${bag.directAddressy};
let dealDirect = ${bag.dealDirect};
let dealDelivery = ${bag.dealDelivery};
$(function() {

	console.log(latitude);
	console.log(longitude);
	if (dealDelivery == 1) {
        $('.delivery').css('background-color', '#b37ade');
    }
	
    $('.delivery').click(function(){
		if (dealDelivery == 1) {
			dealDelivery = 0;
			$(this).css('background-color', '');
		}else {
			dealDelivery = 1;
			$(this).css('background-color', '#b37ade');
		}
		console.log("배송여부 : "+dealDelivery);
	})
	$('.direct').click(function() {
            toggleDealDirect();
        });

        // 초기에 dealDirect 값에 따라 지도의 보이기/숨기기 설정
        if (dealDirect === 1) {
            showMap();
            
        } else {
            hideMap();
            
        }

        // dealDirect 값이 1일 때 지도 보이기
        function showMap() {
            $('#map').css('visibility', 'visible');
            $('.address').css('visibility', 'visible');
            $('.prd-info').css('width', '500px');
            console.log("직거래 여부: " + dealDirect);
            $('.direct').css('background-color', '#b37ade');
        }

        // dealDirect 값이 0일 때 지도 숨기기
        function hideMap() {
            $('#map').css('visibility', 'hidden');
            $('.address').css('visibility', 'hidden');
            $('.prd-info').css('width', '100%');
            console.log("직거래 여부: " + dealDirect);
            $('.direct').css('background-color', '');
        }

        // dealDirect 값 토글 함수
        function toggleDealDirect() {
            if (dealDirect === 1) {
                dealDirect = 0;
                hideMap();
            } else {
                dealDirect = 1;
                showMap();
            }
        }
        
        
        $('#update').click(function() {
        	var memberId = "<%=session.getAttribute("id")%>";
    		var category = $('.category').val();
    		var productName = $('.name').val();
    		var productContent = $('.product-content').val();
    		var price = $('.price').val();
    		console.log("sessionId" + memberId);
    		console.log("latitude" + latitude);
    		console.log("longitude" + longitude);
    		console.log("dealDirect" + dealDirect);
    		console.log("dealDelivery" + dealDelivery);
    		if(dealDirect==1 && longitude<1){
    			alert("직거래 장소를 정해주세요.")
    		}else if(category==null || productName==null || productContent==null || price==null){
    			alert("필수값을 입력해주세요.")
    		}else if(dealDirect==0 && dealDelivery==0){
    			alert("거래방식을 정해주세요.")
    		}
    		else{
    			$.ajax({
    				url : "productUpdate",
    				data : {
    					productId : ${bag.productId},
    					memberId : memberId,
    					category : category,
    					productName : productName,
    					productContent : productContent,
    					price : price,
    					dealDirect : dealDirect,
    					directAddressx : latitude,
    					directAddressy : longitude,
    					dealDelivery : dealDelivery,
    					temporary : 1
    				},
    				success : function(x) {
    						alert("판매글을 수정했습니다.")
    						location.href = "../home/gazeeMain.jsp";
    				},
    			    error: function(xhr, status, error) {
    			        console.log("AJAX 요청 실패");
    			        console.log("상태 코드: " + xhr.status);
    			        console.log("에러 메시지: " + error);
    			    }
    			})
    		}
        });

        // 삭제 버튼 클릭 시 productDelete로 요청 전송
        $('#delete').click(function() {
        	var memberId = "<%=session.getAttribute("id")%>";
        	console.log("sessionId" + memberId);
    		console.log("productId" + ${bag.productId});
            if (confirm('정말로 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'productDelete',
                    type: 'POST',
                    data: {
                        memberId: memberId,
                        productId: ${bag.productId},
                    },
                    success: function(x) {
                            alert('삭제되었습니다.');
                            location.href = "../home/gazeeMain.jsp";
                            
                    }
                });
            }
        });
})
   
</script>
<span id="map"></span>
<table>
	<tr class="each-row">
		<td class="attribute">제목</td>
		<td><input class="prd-info name" type="text"
			value="${bag.productName}"></td>

	</tr>
	<tr class="each-row">
		<td class="attribute">가격</td>
		<td><input class="prd-info price" value="${bag.price}"
			type="number"
			oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>

	</tr>
	<tr class="each-row">
		<td class="attribute">카테고리</td>
		<td><select class="prd-info category" name="category">
				<option value="의류" ${bag.category == '의류' ? 'selected' : ''}>의류</option>
				<option value="잡화" ${bag.category == '잡화' ? 'selected' : ''}>잡화</option>
				<option value="디지털 기기" ${bag.category == '디지털 기기' ? 'selected' : ''}>디지털
					기기</option>
				<option value="생활가전" ${bag.category == '생활가전' ? 'selected' : ''}>생활가전</option>
				<option value="가구/인테리어"
					${bag.category == '가구/인테리어' ? 'selected' : ''}>가구/인테리어</option>
				<option value="뷰티/미용" ${bag.category == '뷰티/미용' ? 'selected' : ''}>뷰티/미용</option>
				<option value="스포츠/레저" ${bag.category == '스포츠/레저' ? 'selected' : ''}>스포츠/레저</option>
				<option value="도서" ${bag.category == '도서' ? 'selected' : ''}>도서</option>
				<option value="반려동물용품" ${bag.category == '반려동물용품' ? 'selected' : ''}>반려동물용품</option>
				<option value="취미/게임/음반"
					${bag.category == '취미/게임/음반' ? 'selected' : ''}>취미/게임/음반</option>
				<option value="생활/주방" ${bag.category == '생활/주방' ? 'selected' : ''}>생활/주방</option>
				<option value="기타" ${bag.category == '기타' ? 'selected' : ''}>기타</option>
		</select></td>
		<td></td>

	</tr>
	<tr class="each-row">
		<td class="attribute">거래방법</td>
		<td class="deal">
			<div>
				<button class="delivery deal-type">
					<span class="material-symbols-outlined">local_shipping</span><br>
					택배거래
				</button>
				<button class="direct deal-type">
					<span class="material-symbols-outlined">partner_exchange</span><br>
					직거래
				</button>
			</div>

			<div class="address">
				직거래 장소 정하기<br> <input class="search" placeholder="직거래 장소 입력">
				<button onclick="getXY()">
					<span class="material-symbols-outlined">search</span>
				</button>
			</div>
		</td>
	</tr>
	<tr class="content-row">
		<td class="attribute">내용</td>
		<td class="content"><textarea class="product-content">${bag.productContent} </textarea></td>
	</tr>
	<tr class="each-row">
		<td class="attribute">사진첨부</td>
		<td><input type="file" value="${bag.productViews}"></td>
	</tr>
</table>
<div>
	<button id="update" class="btn_updel">수정 및 저장</button>
	<button id="delete" class="btn_updel">삭제</button>
</div>

<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	
    mapOption = {
        center: new kakao.maps.LatLng(${bag.directAddressy}, ${bag.directAddressx}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	function getXY(){
	    var address = $('.search').val(); // address-search 입력 필드의 값 가져오기
	    console.log('주소 값 : ' + address)
	    if (address=='') {
	    	alert("주소를 입력해주세요")
	    }else {
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(address, function(result, status) {
		    // 정상적으로 검색이 완료됐으면 
		    if (status === kakao.maps.services.Status.OK) {
		
			       var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
			       console.log('경도, 위도 : ' + result[0].y+", "+ result[0].x);
			       longitude = result[0].y;
	               latitude = result[0].x;
	                
			       // 결과값으로 받은 위치를 마커로 표시합니다
			       var marker = new kakao.maps.Marker({
			           map: map,
			           position: coords
			       });
			
			       // 인포윈도우로 장소에 대한 설명을 표시합니다
			       var infowindow = new kakao.maps.InfoWindow({
			           content: '<div style="width:150px;text-align:center;padding:6px 0;">여기서 만나기</div>'
			       });
			       infowindow.open(map, marker);
			
			       // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			       map.setCenter(coords);
    		}else{console.log("검색 안됨")}
			})
	    }
	}
	</script>
