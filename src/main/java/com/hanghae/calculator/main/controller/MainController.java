package com.hanghae.calculator.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping("/")
    public String index() {
        return "index"; // "index"는 JSP 파일명이 됩니다.
    }
}
