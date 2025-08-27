<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8"> 
	<title>予約一覧</title>
	<link rel="stylesheet" href="style.css">
</head> 
<body>
	<div class="container"> 
		<h1>予約一覧</h1>
		<form action="reservation" method="get" class="search-sort-form"> 
			<input type="hidden" name="action" value="list">
			<div>
				<label for="search">検索:</label>
				<input type="text" id="search" name="search" value="<c:out value="${searchTerm}"/>" placeholder="名前または日時"> 
			</div>
			<div>
				<label for="sortBy">ソート基準:</label> 
				<select id="sortBy" name="sortBy">
					<option value="" <c:if test="${sortBy == null || sortBy == ''}">selected</c:if>>選択してください</option>
					<option value="name" <c:if test="${sortBy == 'name'}">selected</c:if>>名前</option>
					<option value="time" <c:if test="${sortBy == 'time'}">selected</c:if>>日時</option> 
				</select>
			</div> 
			<div>
				<label for="sortOrder">ソート順:</label> 
				<select id="sortOrder" name="sortOrder">
					<option value="asc" <c:if test="${sortOrder == 'asc'}">selected</c:if>>昇順</option>
					<option value="desc" <c:if test="${sortOrder == 'desc'}">selected</c:if>>降順</option> 
				</select>
			</div>
			<button type="submit" class="button">検索/ソート</button> 
		</form>
		<p class="error-message"><c:out value="${errorMessage}"/></p>
		<p class="success-message"><c:out value="${successMessage}"/></p>
		
		<div class="button-group">
			<a href="reservation?action=export_csv" class="button">CSV エクスポート</a> 
			<form action="reservation" method="get" style="display:inline;">
				<input type="hidden" name="action" value="clean_up">
				<input type="submit" value="過去の予約をクリーンアップ" class="button secondary" onclick="return confirm('本当に過去の予約を削除しますか?');">
			</form> 
		</div>
		
		<table> 
			<thead>
				<tr> 
					<th>ID</th>
					<th>名前</th> 
					<th>予約日時</th> 
					<th>操作</th>
				</tr> 
			</thead>
			<tbody>
				<c:forEach var="reservation" items="${reservations}">
					<tr>
						<td>${reservation.id}</td> 
						<td>${reservation.name}</td> 
						<td>${reservation.reservationTime}</td> 
						<td class="table-actions">
							<a href="reservation?action=edit&id=${reservation.id}" class="button">編集</a> 
							<form action="reservation" method="post" style="display:inline;">
								<input type="hidden" name="action" value="delete">
								<input type="hidden" name="id" value="${reservation.id}">
								<input type="submit" value="キャンセル" class="button danger" onclick="return confirm('本当にキャンセルしますか?');"> 
							</form>
						</td> 
					</tr>
				</c:forEach>
				<c:if test="${empty reservations}">
					<tr><td colspan="4">予約がありません。</td></tr> 
				</c:if>
			</tbody> 
		</table>
		
		<div class="pagination">
			<c:if test="${currentPage != 1}">
				<a href="reservation?action=list&page=${currentPage - 1}&search=${searchTerm}&sortBy=${sortBy}&sortOrder=${sortOrder}">前へ</a>
			</c:if>
			<c:forEach begin="1" end="${noOfPages}" var="i"> 
				<c:choose>
					<c:when test="${currentPage eq i}"> 
						<span class="current">${i}</span>
					</c:when> 
					<c:otherwise>
						<a href="reservation?action=list&page=${i}&search=${searchTerm}&sortBy=${sortBy}&sortOrder=${sortOrder}">${i}</a>
					</c:otherwise> 
				</c:choose>
			</c:forEach>
			<c:if test="${currentPage lt noOfPages}">
				<a href="reservation?action=list&page=${currentPage + 1}&search=${searchTerm}&sortBy=${sortBy}&sortOrder=${sortOrder}">次へ</a>
			</c:if> 
		</div>
		<div class="button-group">
			<a href="index.jsp" class="button secondary">トップに戻る</a>
		</div> 
	</div>
</body> 
</html>