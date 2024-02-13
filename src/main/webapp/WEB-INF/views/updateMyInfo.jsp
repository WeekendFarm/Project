<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>

<div class="join-wrap">
    <div class="join-form">
        <form action="myPagePassCheck" method="post" id="myPagePassCheck">
            <h3>회원정보 변경을 위해 비밀번호를 입력해주세요</h3>
            <div id="cancelFail" style="display: none;">
                <p class="fail_check">
                    <b>비밀번호가 일치하지 않습니다</b>
                </p>
            </div>

            <ul>
                <li class="join-input-box m-top">
                    <p>비밀번호 입력</p>
                    <input type="password" name="pass" placeholder="비밀번호를 입력해주세요">
                </li>
                <li>
                    <input id="myPagePassCheckBtn" class="btn-login m-top" type="submit" value="회원정보 변경하기">
                </li>
            </ul>
            <input type="hidden" name="memid">
        </form>
        <div id="updateMyInfo-wrap" style="display:none;">
            <form action="updateMyInfoForm" method="post" id="updateMyInfo" modelAttribute="inputMyInfo" enctype="multipart/form-data">
                <ul style="list-style-type: none">
                    <li>
                        <h3><p>${loginUser.memid}님 회원정보 변경</p></h3>
                        <h4>반드시 기존 비밀번호를 입력해주세요</h4>
                    </li>
                    <li class="join-input-box">
                        <p>기존 비밀번호 입력</p>
                        <input type="password" name="pass" id="pass" placeholder="비밀번호를 입력해주세요">
                    </li>
                    <li class="join-input-box">
                        <p>이름</p>
                        <input name="name" id="name"  value="${loginUser.name}">
                        <div id="checkNameResult" style="font-size:0.8em; display:none;"></div>
                    </li>
                    <li class="join-input-box">
                        <p>생년월일</p>
                        <input name="birth" id="birth"  value="${loginUser.birth}">
                        <div id="checkBirthResult" style="font-size:0.8em; display:none;"></div>
                    </li>
                    <li class="join-input-box">
                        <p>휴대전화번호</p>
                        <input name="phone" id="phone"  value="${loginUser.phone}">
                        <div id="checkPhoneResult" style="font-size:0.8em; display:none;"></div>
                    </li>
                    <li>
                        <div class="email_box">
                            <div class="email-input-box">
                                <p>이메일</p>
                                <input type="hidden" id="loginEmail" value="${loginUser.email}">
                                <input type="text" name="a_email" id="a_email" class="form-control"> <b>@</b>
                            </div>
                            <div class="email-select-box">
                                <input type="text" name="b_email" id="b_email" class="form-control" ReadOnly="true"/>
                                <select name="emailCheck" id="emailCheck" onchange="SetEmailTail(emailCheck.options[this.selectedIndex].value)" class="form-control">
                                    <option value="">메일 선택</option>
                                    <option value="etc" selected>직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="daum.net">daum.net</option>
                                    <option value="nate.com">nate.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                </select>
                            </div>
                        </div>
                    </li>
                    <li class="file-top">
                        <p>프로필이미지</p>
                        <input type="file" name="file" id="file" class="btn-file">
                        <span class="modi_img" >
                        <img src="" alt="" id="View">
                    </span>
                    </li>
                    <li>
                        <input class="btn-join" type="submit" value="회원정보변경">
                    </li>
                    <li>
                        <a href="cancelAccount">회원탈퇴</a>
                    </li>
                </ul>
            </form>
        </div>
    </div>
</div>
<script>
    $(()=>{
        $("form[id='myPagePassCheck']").submit(function(e){
            e.preventDefault();

            var formData = $(this).find('input[name="pass"]').val();

            var email = $("#loginEmail").val();
            var atIndex = email.indexOf("@");
            var a_email = email.substring(0,atIndex);
            var b_email = email.substring(atIndex+1);

            $.ajax({
                type:"POST",
                url:"/myPagePassCheck",
                data : {pass:formData},
                success:function(response){
                    if(response==true){
                        $("#updateMyInfo-wrap").show();
                        $("#myPagePassCheck").hide();

                        $("#a_email").val(a_email);
                        $("#b_email").val(b_email);

                    }else{
                        $("#cancelFail").show();
                    }
                }
            })
        })
    });
    /////////////////////이메일
    function SetEmailTail(emailValue) {
        var email = document.all("a_email")    // 사용자 입력
        var emailTail = document.all("b_email") // Select box

        if ( emailValue == "notSelected" )
            return;
        else if ( emailValue == "etc" ) {
            emailTail.readOnly = false;
            emailTail.value = "";
            emailTail.focus();
        } else {
            emailTail.readOnly = true;
            emailTail.value = emailValue;
        }
    }
    function validateForm() { //form에 온서브밋이 있을경우 없으면 버튼 아이디 클릭해서 이용하시길 - onsubmit="return validateForm()"
        var mail1 = $('#a_email').val();
        var mail2 = $('#b_email').val();
        var real_mail = mail1 +'@' + mail2;
        $("#email").val(real_mail);
        return false;
    }
</script>
<%@include file="../include/footer.jsp" %>