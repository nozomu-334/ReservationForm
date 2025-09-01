<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>簡易予約システム</title>
<link rel="stylesheet" href="style.css">
<script>
        // 席選択の自動反映
        function selectSeat(seatId) {
            const seatButton = document.getElementById(seatId);
            const seatsInput = document.getElementById('seats');
            let selectedSeats = seatsInput.value ? seatsInput.value.split(',') : [];

            if (selectedSeats.includes(seatId)) {
                selectedSeats = selectedSeats.filter(s => s !== seatId);
            } else {
                selectedSeats.push(seatId);
            }
            seatsInput.value = selectedSeats.join(',');
        }
    </script>
</head>
<body>
	<div class="container">
		<h1>予約入力</h1>
		<form action="reservation" method="post">
			<input type="hidden" name="action" value="add">
			<p>
				<label for="name">名前:</label> <input type="text" id="name"
					name="name" value="<c:out value='${param.name}'/>" required>
				<span class="error-message"><c:out value="${errorMessage}" /></span>
			</p>
			<p>
				<label for="reservation_time">希望日時:</label> <input
					type="datetime-local" id="reservation_time" name="reservation_time"
					value="<c:out value='${param.reservation_time}'/>" required>
				<span class="error-message"><c:out value="${errorMessage}" /></span>
			</p>
			<p>
				<label for="numberOfPeople">人数:</label> <input type="number"
					id="numberOfPeople" name="numberOfPeople" min="1" max="10"
					value="<c:out value='${param.numberOfPeople}'/>" required>
			</p>
			<p>
				<label>席を選択 (最大4名、C席は1名まで):</label>
			<div class="seats">
				<c:forEach var="seat"
					items="${['M1','M2','M3','C1','C2','C3','C4','1','2','3','4','5','6','7','8','9','10','O1','O2','O3','O4','O5','O6','O7','O8','O9','O10']}">
					<button type="button" id="${seat}" onclick="selectSeat('${seat}')">${seat}</button>
				</c:forEach>
			</div>
			</p>
			<input type="hidden" id="seats" name="seats"
				value="<c:out value='${param.seats}'/>">
			<div class="button-group">
				<input type="submit" value="予約する">
			</div>
		</form>

		<hr>

		<h2>CSV インポート</h2>
		<form action="reservation" method="post" enctype="multipart/form-data">
			<input type="hidden" name="action" value="import_csv">
			<p>
				<label for="csvFile">CSV ファイルを選択:</label> <input type="file"
					id="csvFile" name="csvFile" accept=".csv" required>
			</p>
			<div class="button-group">
				<input type="submit" value="インポート">
			</div>
		</form>

		<p class="error-message">
			<c:out value="${errorMessage}" />
		</p>
		<p class="success-message">
			<c:out value="${successMessage}" />
		</p>

		<div class="button-group">
			<a href="reservation?action=list" class="button secondary">予約一覧を見る</a>
		</div>
	</div>
</body>
</html>