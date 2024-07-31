<%@page import="java.util.*" %>
<%@page import="cn.techMahindraProjects.model.*"%>
<%@page import="cn.techMahindraProjects.dao.*"%>
<%@page import="cn.techMahindraProjects.connection.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list=(ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart>cartProducts=null;

if(cart_list !=null){
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	cartProducts=pDao.getCartProducts(cart_list);
	request.setAttribute("cart_list",cart_list);
}

int sum=0;
for(Cart c:cartProducts){
	sum+=c.getPrice();
}

%>
<!DOCTYPE html>
<html>
<head>
<%@include file="includes/head.jsp"%>
<style>
.table tbody td{
vertical-align:middle;
}
.btn-incre, .btn-decre{
box-shadow:none;
font-size:25px;
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>Total Price:<%= sum %></h3>
			<a class="mx-3 btn btn-primary" href="#">Check out</a>
			</div>
			<table class="table table-length">
				<thead>
					<tr>
						<th scope="col">Name</th>
						<th scope="col">Category</th>
						<th scope="col">Price</th>
						<th scope="col">Buy Now</th>
						<th scope="col">Cancel</th>
					</tr>
				</thead>
				<tbody>
				<%
					
					if(cart_list != null){
						for(Cart c:cartProducts){
							sum=sum+c.getPrice();
						%>
							<tr>
							<td><%=c.getName()%></td>
							<td><%=c.getCategory()%></td>
							<td><%=c.getPrice()%></td>
							<td>
								<form action="" method="post" class="form-inline">
									<input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
									<div class="form-group d-flex justify-content-between">
										<a class="btn btn-sm btn-incre"><i
											class="fas fa-plus-square"></i></a> <input type="text"
											name="quantity" class="form-control" value="1" readonly /> <a
											class="btn btn-sm btn-decre"><i
											class="fas fa-minus-square"></i></a>
									</div>
								</form>
							</td>
							<td><a class="btn btn-sm btn-danger" href="">Remove</a></td>
						</tr>
						
						<% }
					}
				%>
					
				</tbody>
			</table>
		</div>
	
	<%@include file="includes/footer.jsp"%>
</body>
</html>