<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<script src="js/status.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<jsp:include page="head.jsp">
	<jsp:param name="title" value="Home" />
</jsp:include>
<body>
	<jsp:include page="header.jsp">
		<jsp:param name="title" value="Home" />
	</jsp:include>
	<main>
<c:if test="${errors.size()>0 }">
	<div class="danger">
		<ul>
			<c:forEach var="error" items="${errors }">
				<li>${error }</li>
			</c:forEach>
		</ul>
	</div>
</c:if> <c:choose>
	<c:when test="${user!=null}">
		<p>Welcome ${user.getFirstName()}!</p>

        <p id="status"><c:out value="${user.getStatus()}"></c:out></p>


		<input type="text" id="input" placeholder="Please give your status">
		<input type="button" value="Set Status" id="submitStatus">

		<table id="friendlist">
		</table>

        <p>Add a friend!</p>
        <input type = "text" id="addFriendInput" placeholder="Give the name of your friend">
        <input type = "button" value="Add!" id="addFriendButton">
		<form method="post" action="Controller?action=LogOut">
			<p>
				<input type="submit" id="logoutbutton" value="Log Out">
			</p>
		</form>
	</c:when>
	<c:otherwise>
		<form method="post" action="Controller?action=LogIn">
			<p>
				<label for="email">Your email </label>
				<input type="text" id="email" name="email" value="jan@ucll.be">
			</p>
			<p>
				<label for="password">Your password</label>
				<input type="password" id="password" name="password" value="t">
			</p>
			<p>
				<input type="submit" id="loginbutton" value="Log in">
			</p>
		</form>
	</c:otherwise>
</c:choose>
	<form id="form">
		<input type="radio" id="uOkey" name="topic">
		<label for="uOkey">Hoe gaat het?</label><br>
		<input type="radio" id="kleur" name="topic">
		<label for="kleur">Wat is je lievelings kleur?</label><br>
		<input type="radio" id="lied" name="topic">
		<label for="lied">Wat is je lievelings leid?</label><br>
		<input type="radio" id="huisdier" name="topic">
		<label for="huisdier">Heb je huisdieren?</label><br>
		<input type="radio" id="sport" name="topic">
		<label for="sport">Welke sport doe je?</label><br>

		<label for="naam">Name</label><input id="naam" type="text"  required>

		<label for="comment">Comment:</label><input id="comment" type="text" required>

		<label for="rating">Rating</label><input id="rating" type="number" min="0" max="10" required>
		<button id="sendButton" type="button">Add Comment</button>

	</form>

	<div id="messages"></div>
		</body>


	</main>

	<jsp:include page="footer.jsp">
		<jsp:param name="title" value="Home" />
	</jsp:include>
	<script>
        $("#submitStatus").click(function() {
            changeStatus();
        });
        $("#addFriendButton").click(function() {
            addFriend();
        });


		$("#sendButton").click(function() {
			send();
		});


		var webSocket;
		var messages = document.getElementById("messages");

		function openSocket(){
			webSocket = new WebSocket("ws://localhost:8081/echo");

			webSocket.onmessage = function(event){
				writeResponse(event.data);
			};

		}

		function send(){


			var idSelectedRadioButton = $("input[name='topic']:checked").attr('id');
			var associatedLabel = $("label[for='" + idSelectedRadioButton + "']").text();


			var message = "     " + associatedLabel + "<br>" + document.getElementById("naam").value + ": " + document.getElementById("comment").value + " -> Rating: " + document.getElementById("rating").value + "<br>";
			webSocket.send(message);
		}

		function closeSocket(){
			webSocket.close();
		}

		function writeResponse(text){
			messages.innerHTML += "<br/>" + text;
		}

		openSocket();
	</script>




</html>