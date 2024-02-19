package com.farm.filter;

import com.farm.domain.Member;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class CustomInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
      /*  String requestURI = request.getRequestURI();
        // 루트 페이지와 로그인 페이지를 제외한 나머지 경로에 대해서만 처리
        if (!requestURI.equals("/") && !requestURI.startsWith("/login")) {
            // 여기서 다른 예외 페이지를 만들어서 리다이렉션하거나 403 Forbidden 등의 처리를 할 수 있음
            response.sendRedirect("/");
            return false;
        }
        return true;
    }*/

        HttpSession session = request.getSession();
        session.setAttribute("isLoggedIn",true);
        String requestURI = request.getRequestURI();

        // 세션에 로그인 정보가 있는지 확인
        boolean isLoggedIn = session.getAttribute("loginUser") != null && (Boolean) session.getAttribute("isLoggedIn");

        // 로그인 페이지 및 루트 페이지 요청인 경우는 허용
        if (requestURI.equals("/") || requestURI.startsWith("/login") || requestURI.startsWith("/join")
                || requestURI.startsWith("/list") || requestURI.startsWith("/board") || requestURI.startsWith("/story")) {
            return true;
        }/*else{
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Forbidden");
        }*/

        // 로그인한 사용자일 경우 페이지 이동 허용
        if (isLoggedIn) {
            return true;
        } else {
            // 로그인하지 않은 사용자일 경우 현재 페이지의 URL을 세션에 저장하여 로그인 후 리다이렉션 시 사용
            session.setAttribute("redirectUrl", requestURI);
            // 로그인 페이지로 리다이렉션
            response.sendRedirect("/login");
            return false;
        }
    }
}