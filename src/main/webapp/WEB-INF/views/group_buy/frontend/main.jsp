<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網首頁</title>
		<!-- slider css-->
    <link rel="stylesheet" type="text/css" href="/GroupBuy/node_modules/slick-master/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="/GroupBuy/node_modules/slick-master/slick/slick-theme.css" />
    <%@include file="../header.jspf" %>
    
	</head>
	<body>
		<!-- menu -->
		<%@include file="../menu.jspf" %>

		
		<!-- 輪播畫面 Carousel -->		
			
		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
				<div class="d-flex justify-content-center">
		      	<img src="https://media.karousell.com/media/photos/special-collection/2023/11/20/9dc19b0e612a8cff_(1500,610)" class="d-block mx-auto w-50" alt="...">      	
		      	<img src="https://media.karousell.com/media/photos/special-collection/2023/03/20/d44f19ee73039476_(1500,610)" class="d-block mx-auto w-50" alt="...">
		    	</div>
		    </div>
		    <div class="carousel-item">
		    	<div class="d-flex justify-content-center">
		      	<img src="https://media.karousell.com/media/photos/special-collection/2023/10/16/40366c562bdb5174_(1500,610)" class="d-block mx-auto w-50" alt="...">
		      	<img src="https://media.karousell.com/media/photos/special-collection/2023/12/07/d41e918db6e9e532_(1500,610)" class="d-block mx-auto w-50" alt="...">
		    	</div>
		    </div>
		  </div>
		 
		<div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
	  </div>		
	  
	  
	 		<hr class="separator">

	  
	       <!-- 輪播畫面 Carousel2 -->
        <div class="mb-5 d-flex flex-column align-items-start" id="travelTheme">
            <div class="travelThemeH1  mt-2 ">猜你會喜歡</div>
            <div class="travelThemeSlider">
                <div><img src="https://media.karousell.com/media/photos/special-collection/2023/11/20/9dc19b0e612a8cff_(1500,610)"></div>
                <div><img src="https://media.karousell.com/media/photos/special-collection/2023/03/20/d44f19ee73039476_(1500,610)"></div>
                <div><img src="https://media.karousell.com/media/photos/special-collection/2023/10/16/40366c562bdb5174_(1500,610)"></div>
                <div><img src="https://media.karousell.com/media/photos/special-collection/2023/12/07/d41e918db6e9e532_(1500,610)"></div>
                <div><img src="https://media.karousell.com/media/photos/special-collection/2023/11/20/9dc19b0e612a8cff_(1500,610)"></div>
                <div><img src="https://media.karousell.com/media/photos/special-collection/2023/03/20/d44f19ee73039476_(1500,610)"></div>
            </div>
        </div>



		
		
		<hr class="separator">
		
		
		<!-- 圖片icon 標題 -->
		<div class="D_bvs M_beb">
	   		 <div class="text-container">
	        	<h3 class="D_bvl D_bvo D_nX M_iW D_oc M_jb D_og M_jf D_ok" data-testid="fieldset-homegroup-generic-heading-category_browser">What would you like to find?</h3>
	        	<span class="D_bvw M_beg">
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_pa M_iK D_pc M_iM D_bvu M_bee D_pg" style="color:#008f79">See all categories</p>
	        	</span>
	    	</div>
		</div>

		</br>
		
		<!-- 圖片icon -->
		<div class="D_bHY M_btq d-flex" style="grid-template-columns: repeat(7, minmax(0, 1fr))">
		<a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/property-for-sale/h-377/?t-source=homepage">
		    <div class="D_bIa M_bts">
		        <div>
		            <span class="D_pz D_bIb D_p_">
		                <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/73/2020/01/22/56-Property-cxxhdpi_1579664037.67.png" title="" style="border-radius: 8px;">
		            </span>
		        </div>
		        <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
		            💰 Property
		        </p>
		    </div>
		</a>

	    <a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/used-cars-singapore/h-1233/?t-source=homepage">
	        <div class="D_bIa M_bts ">
	            <div>
	                <span class="D_pz D_bIb D_p_">
	                    <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/22/2020/01/22/56-Cars-cxxhdpi_1579663915.34.png" title="" style="border-radius: 8px;">
	                </span>
	            </div>
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
	                🚗 Cars
	            </p>
	        </div>
	    </a>
	    <a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/home-services/h-1708/?t-source=homepage">
	        <div class="D_bIa M_bts text-center">
	            <div>
	                <span class="D_pz D_bIb D_p_">
	                    <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/1908/2019/08/01/56-Home_Services-c_1564657665.98.png" title="" style="border-radius: 8px;">
	                </span>
	            </div>
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
	                ⚒️ Home Services
	            </p>
	        </div>
	    </a>
	    <a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/smart_render/?name=ap-mobiles-gadgets&amp;t-source=homepage&amp;type=market-landing-page">
	        <div class="D_bIa M_bts text-center">
	            <div>
	                <span class="D_pz D_bIb D_p_">
	                    <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/main_v2/02_mobile_phones_gadgets.png" title="" style="border-radius: 8px;">
	                </span>
	            </div>
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
	                📱 Mobile Phones & Gadgets
	            </p>
	        </div>
	    </a>
	    <a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/womens-fashion/h-2/?t-source=homepage">
	        <div class="D_bIa M_bts text-center">
	            <div>
	                <span class="D_pz D_bIb D_p_">
	                    <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/main_v2/08_womens_fashion.png" title="" style="border-radius: 8px;">
	                </span>
	            </div>
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
	                👗 Women’s Fashion
	            </p>
	        </div>
	    </a>
	    <a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/men-s-fashion/h-6/?t-source=homepage">
	        <div class="D_bIa M_bts text-center">
	            <div>
	                <span class="D_pz D_bIb D_p_">
	                    <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/main_v2/09_mens_fashion.png" title="" style="border-radius: 8px;">
	                </span>
	            </div>
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
	                👕 Men’s Fashion
	            </p>
	        </div>
	    </a>
	    <a class="D_bHZ M_btr D_px M_ix text-decoration-none" href="/luxury/h-9/?t-source=homepage">
	        <div class="D_bIa M_bts text-center">
	            <div>
	                <span class="D_pz D_bIb D_p_">
	                    <img alt="" class="D_pB" src="https://media.karousell.com/media/photos/country-collections/icons/main_v2/10_luxury.png" title="" style="border-radius: 8px;">
	                </span>
	            </div>
	            <p class="D_oP M_iz D_oQ M_i_ D_oU M_iE D_oX M_iH D_oZ M_iJ D_pc M_iM D_bIg M_btx D_ph text-decoration-none" style="color:#57585a">
	                💎 Luxury
	            </p>
	        </div>
	    </a>
	</div>

		
		<hr class="separator">
		
		<!-- footer -->	
		
		<div class="container">
		  <footer class="py-3 my-4">
		    <ul class="nav justify-content-center border-bottom pb-3 mb-3">
		      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Home</a></li>
		      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Features</a></li>
		      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Pricing</a></li>
		      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">FAQs</a></li>
		      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">About</a></li>
		    </ul>
		    <p class="text-center text-muted">© 2024 Company, Inc</p>
		  </footer>
		</div>
	
      
	 <!-- slider js-->
    <%@include file="../body.jspf" %>
    <script type="text/javascript" src="/GroupBuy/node_modules/slick-master/slick/slick.min.js"></script>
    
    
    
    <script type="text/javascript">
    $('.travelThemeSlider').slick({
        infinite: true,
        slidesToShow: 4,
        slidesToScroll: 1,
        responsive: [
            {
                breakpoint: 1200,
                settings: {
                    slidesToShow: 3,
                }
            },
            {
                breakpoint: 800,
                settings: {
                    slidesToShow: 2,
                }
            },
            {
                breakpoint: 500,
                settings: {
                    slidesToShow: 1,
                    arrows: false,
                    autoplay: true,
                    autoplaySpeed: 3000,
                }
            }
        ]
    });
    </script>	
	</body>
</html>