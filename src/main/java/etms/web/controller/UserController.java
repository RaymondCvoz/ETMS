package etms.web.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/user")
public class UserController
{
    @RequestMapping("/index")
    public ModelAndView indexView(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView view = null;
        view = new ModelAndView("testpage");
        return view;
    }
}
