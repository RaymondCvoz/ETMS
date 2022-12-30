package etms.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value = "/")
public class DefaultController
{
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public ModelAndView indexView(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView view = null;
        view = new ModelAndView("index");
        return view;
    }

    @RequestMapping(value = "/help",method = RequestMethod.GET)
    public ModelAndView helpView(HttpServletRequest request, HttpServletResponse response)
    {
        ModelAndView view = null;
        view = new ModelAndView("misc/help");
        return view;
    }

    @RequestMapping(value = "/about",method = RequestMethod.GET)
    public ModelAndView aboutView(HttpServletRequest request,HttpServletResponse response)
    {
        ModelAndView view = null;
        view = new ModelAndView("misc/about");
        return view;
    }
}
