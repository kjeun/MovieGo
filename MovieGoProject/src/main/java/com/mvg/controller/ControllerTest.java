package com.mvg.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.mvg.entity.User;
import com.mvg.service.UserService;

@Controller
@SessionAttributes({ "log", "user" })
public class ControllerTest {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(ControllerTest.class);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) throws Exception {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

		binder.registerCustomEditor(Date.class, "userBirthday",
				new CustomDateEditor(simpleDateFormat, true));
	}

	@Autowired
	UserService service;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainTest(Model model) {
		model.addAttribute("log", new User());
		return "main";
	}

	@RequestMapping(value = "/find_user_info", method = RequestMethod.GET)
	public String idConfirmTest() {
		return "user/find_user_info";
	}

	/*
	 * @RequestMapping(value="/login", method=RequestMethod.POST) public String
	 * login(Model model, @ModelAttribute("user") User user, HttpSession
	 * session){ User u = service.getUserByUserId(user);
	 * model.addAttribute("user", session.getAttribute("user")); return
	 * "user/main_logined"; }
	 */

	@RequestMapping(value = "/login", params = "_event_confirmed", method = RequestMethod.POST)
	public String login(Model model, @ModelAttribute("log") User log,
			HttpSession session) {
		User u = service.getUserByUserId(log);
		model.addAttribute("user", u);
		return "user/main_logined";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(@ModelAttribute("log") User log,
			SessionStatus sessionStatus) {
		sessionStatus.setComplete();
		return "redirect:/main";
	}

	@RequestMapping(value = "/signup", params = "_event_confirmed", method = RequestMethod.POST)
	public String mainLogined(User user, Model model) {
		service.insertUser(user);
		return "main";
	}

	@RequestMapping(value = "/board_view", method = RequestMethod.GET)
	public String boardview() {
		return "board/board_view";
	}

	/*@RequestMapping(value = "/test/SessionCheck")
	@ResponseBody
	public void selectDetail3(HttpSession session,
			@ModelAttribute("SessionVO") SessionVO sessionVO,
			HttpServletResponse response) throws JsonGenerationException,
			JsonMappingException, IOException {

		// 이부분에 세션 체크 넣어주면됨.
		sessionVO sessionVO = CommonUtil.getSessionVOInfo("user");

		String check = null;
		if (sessionVO != null) {
			check = "ok";
		}

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		if (check != null) {
			out.print(check);
		} else {
			// 실패 메시지
			out.print("");
		}

	}*/
}
