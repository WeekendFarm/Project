package com.farm.controller;

import com.farm.domain.Member;
import com.farm.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"loginUser"})
public class MyPageController {
    @Autowired
    MemberService memberService;

    @Autowired
    PasswordEncoder pEncoder;

    @GetMapping("/myPage")
    public String myInfoForm(){
        return "myPage";
    }

    @GetMapping("/updateMyInfo")
    public String updateMyInfo(){
        return "updateMyInfo";
    }

    @PostMapping("/myPagePassCheck")
    @ResponseBody
    public Boolean myPagePassCheck(@RequestParam("pass") String checkPass,
                                   HttpSession session){
        System.out.println("checkPass:"+checkPass);
        Member loginUser = (Member) session.getAttribute("loginUser");

        if(loginUser != null && pEncoder.matches(checkPass,loginUser.getPass())){
            session.setAttribute("loginUser",loginUser);

            return true;

        }else{
            return false;
        }
    }

    /*
     * 세션정보 업데이트 안됨 -> 모델로 해결
     * 정보변경할 때 비밀번호 확인 js추가 해야함
     * 회원정보 수정 이름 외에 다른것도 다 되게 바꿔야함
     */

    @PostMapping("/updateMyInfoForm")
    public String updateMyInfoForm(@ModelAttribute("inputMyInfo") Member iMyInfo,
                                   HttpSession session, Model model,
                                   RedirectAttributes redirectAttributes){

        Member loginUser = (Member) session.getAttribute("loginUser");
        Member updatedMember = memberService.updateMyInfo(iMyInfo,loginUser.getMemid());
        model.addAttribute("loginUser",updatedMember);
        model.addAttribute("updateInfo",false);

        return "updateMyInfo";
    }

    @GetMapping("/updatePass")
    public String updatePass(){
        return "updatePassForm";
    }

    @PostMapping("/updatePass")
    public String updatePass(@RequestParam("memid") String memid,
                             @RequestParam("pass") String newPass,
                             HttpSession session,
                             SessionStatus status){
        Member loginUser = (Member)session.getAttribute("loginUser");
        String pass = pEncoder.encode(newPass);

        if(loginUser != null){
            memberService.updatePass(loginUser.getMemid(), pass);

            if(!status.isComplete()){
                status.setComplete();
            }
        }else{
            System.out.println("비밀번호변경실패");
        }

        return "redirect:/completePass"; // 비밀번호 변경완료 페이지
    }

    @GetMapping("/completePass")
    public String completePass(){
        return "completePass";
        // return "redirect:/completePass"됐을 때 받을 GetMapping
    }

    @GetMapping("/cancelAccount")
    public String deleteAccount(){
        return "cancelAccount";
    }

    @PostMapping("/cancelAccountForm")
    public String cancelAccountForm(HttpSession session,
                                    @RequestParam("cancelPass") String cancelPass,
                                    SessionStatus status,
                                    Model model){
        Member loginUser = (Member)session.getAttribute("loginUser");


        if(!status.isComplete() && pEncoder.matches(cancelPass,loginUser.getPass())){
            memberService.cancelAccount(loginUser.getMemid());
            status.setComplete();

            return "redirect:/getOut";

        }else if(!pEncoder.matches(cancelPass,loginUser.getPass())){
            model.addAttribute("isOutUser",false);
            return "cancelAccount";

        }
        return "cancelAccount";
    }

    @GetMapping("/getOut")
    public String getOut(){
        return "getOut";
        // getOut 리다이렉트용
    }

    // 작성한 글 찾기
    // memid값과 story_mem_id값이 일치하는 경우 story_subject 가져오기
}