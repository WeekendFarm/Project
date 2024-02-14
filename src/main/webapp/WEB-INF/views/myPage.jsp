<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<c:if test="${empty loginUser}">
    <script>
        alert("로그인 후 작성 가능합 니다.");
        location.href="/login";
    </script>
</c:if>
<div class="con wrap m-top">
    <h3><p>${loginUser.memid}님 회원정보</p></h3>
    <input type="hidden" name="memid" value="${loginUser.memid}">
    <div class="my-full-wrap">
        <div class="my-tap-wrap">
            <div class="my-tap">
                <ul>
                    <li>
                        <a href="updateMyInfo">
                            <input class="btn-join" type="button" value="회원정보변경">
                        </a>
                    </li>
                    <li>
                        <a href="updatePass">
                            <input class="btn-join" type="button" value="비밀번호변경">
                        </a>
                    </li>
                    <li>
                        <a href="cancelAccount">
                            <input class="btn-join" type="button" value="회원탈퇴">
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <input class="btn-join" type="button" value="예약내역이여기요?">
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <input class="btn-join" type="button" value="리뷰도어쩌구?">
                        </a>
                    </li>
                </ul>
            </div>

            <div class="my-wrap">
                <ul class="my-info-wrap">
                    <li class="file-top my-img">
                        <p>프로필이미지</p>
                        <span>
                            <img src="${loginUser.memImg}" onerror="this.src='img/profileImg_w.png'">
                        </span>
                    </li>
                    <li class="my-info">
                        <p>이름</p>
                        <input name="name" id="name"  value="${loginUser.name}" readonly>
                        <p>생년월일</p>
                        <input name="birth" id="birth"  value="${loginUser.birth}" readonly>
                        <p>이메일</p>
                        <input type="text" name="email" id="email" class="form-control" value="${loginUser.email}" readonly>
                    </li>
                </ul>
                <div class="my-resv-wrap m-top">
                    예약내역
                    <table>
                        <thead>
                        <tr>
                            <th>예약상태</th>
                            <th>No</th>
                            <th>농장</th>
                            <th>예약기간</th>
                            <th>예약날짜</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${reservations ne null}">
                                <c:forEach var="resv" items="${reservations}" varStatus="i">
                                    <fmt:parseDate value="${resv.rvDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime" type="both" />
                                    <tr>
                                        <td>${resv.status}</td>
                                        <td>${i.count}</td>
                                        <td>${resv.rvFarmIdx}</td>
                                        <td><a href="reservationDetail?id=${resv.rvIdx}" class="ellipsis">${resv.rvUseDate}</a></td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd'T'HH:mm" value="${parsedDateTime}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3">자료가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                <div class="my-review-wrap">
                    리뷰
                    <table>
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>제목</th>
                            <th>리뷰작성일자</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${reviews ne null}">
                                <c:forEach var="review" items="${reviews}" varStatus="i">
                                    <fmt:parseDate value="${review.reviewDate}" pattern="yy. M. d. a h:mm" var="parsedDateTime" type="both" />
                                    <tr>
                                        <td>${i.count}</td>
                                        <td><a href="reviewDetail?id=${review.reviewIdx}" class="ellipsis">${review.reviewSubject}</a></td>
                                        <td><fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3">자료가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                <div class="my-story-wrap">
                    스토리
                    <table>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>제목</th>
                                <th>날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${stories ne null}">
                            <c:forEach var="story" items="${stories}" varStatus="i">
                                <fmt:parseDate value="${story.storyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                <tr>
                                    <td>${i.count}</td>
                                    <td><a href="storyDetail?id=${story.storyIdx}" class="ellipsis">${story.storySubject}</a></td>
                                    <td><fmt:formatDate pattern="yyyy.MM.dd" value="${parsedDateTime}" /></td>
                                </tr>
                            </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3">자료가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </div>
</div>

<%@include file="../include/footer.jsp" %>