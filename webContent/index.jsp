<%@page import="java.util.List"%>
<%@page import="cn.techMahindraProjects.connection.DbCon"%>
<%@page import="cn.techMahindraProjects.model.*"%>
<%@page import="cn.techMahindraProjects.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
ProductDao pd=new ProductDao(DbCon.getConnection());
List<Product>products=pd.getAllProducts();

%>
<!DOCTYPE html>
<html>
<head>
<title>welcome to shopping cart</title>
<%@include file="includes/head.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">ALL PRODUCTS</div>
		<%
		if(auth!=null){%>
			<h1 style="color:green;text-align:center;">WELCOME BACK FOODIE</h1>
		<%}
		else{ %>
			<h1 style="color:red; text-align:center;">YOU ARE NOT LOGGED IN</h1>
		<%}
		%>
		<div class="row">
		
		<%
		
		if(!products.isEmpty()){
			for(Product p:products){%>
				<div class="col-md-3">
				<div class="card w-100" style="width: 18rem;">
					<img class="card-img-top" src=<%=p.getImage()%> >
					<div class="card-body">
						<h5 class="card-title"><%= p.getName() %></h5>
						<h6 class="price">price:<%= p.getPrice() %></h6>
						<h6 class="category"><%= p.getCategory() %></h6>
						
						<div class="mt-3 d-flex justify-content-between">
							<a href="add-to-cart?id=<%=p.getId() %>" class="btn btn-dark">Add to Cart</a>
							<a href="#" class="btn btn-primary">Buy now</a>
						</div>
						

					</div>
				</div>				
			</div>
			<%}
		}
		%>
			
		</div>
	</div>


		<%@include file="includes/footer.jsp"%>
</body>
</html>