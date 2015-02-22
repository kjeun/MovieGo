package com.mvg.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mvg.entity.SeatInfo;
import com.mvg.entity.Theater;
import com.mvg.entity.User;
import com.mvg.service.MovieService;
import com.mvg.service.NowMovieService;
import com.mvg.service.ReservationService;
import com.mvg.service.SeatInfoService;
import com.mvg.service.TheaterService;

@Controller
public class ReservationController {
	
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(ControllerTest.class);
	}

	@Autowired
	ReservationService rservice;
	
	@Autowired
	TheaterService tservice;
	
	@Autowired
	NowMovieService nservice;
	
	@Autowired
	MovieService mservice;
	
	@Autowired
	SeatInfoService sservice;
	
	
	private int thId;
	private String mCode;
	private String mTime;
	private int nmId;
	private String rinfo;
	private ArrayList<String> seats;
	private int peopleNum;
	
	
	@RequestMapping(value="/reserve",  method=RequestMethod.GET)
	public String reserveMovieCall(Model model){
		List<Theater> theaters = tservice.getAllTheatersService();
		model.addAttribute("theaters", theaters);
		return "reservation/reservation1";
	}
	
	@RequestMapping(value="/reserve/theater", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public @ResponseBody String theaterReceive(@RequestParam int theaterId, Model model) {
		
		thId = theaterId;
		logger.trace("수업: 극장아이디: "+thId);
		
		Map<String, String> codesAndNames = nservice.getAllNMovieNamesService(thId);
		Iterator<String> iter = codesAndNames.keySet().iterator();
		
		StringBuilder jsonBuilder = new StringBuilder();
		
		jsonBuilder.append("{\"movies\":[");
		if(iter.hasNext()) {
			String key = iter.next();
			String value = codesAndNames.get(key);
			jsonBuilder.append("{\"code\":")
				.append(key)
				.append(", ")
				.append("\"movieName\":")
				.append("\"")
				.append(value)
				.append("\"")
				.append("}");
		}
		while(iter.hasNext()) {
			jsonBuilder.append(", ");
			String key = iter.next();
			String value = codesAndNames.get(key);
			jsonBuilder.append("{\"code\":")
				.append(key)
				.append(", ")
				.append("\"movieName\":")
				.append("\"")
				.append(value)
				.append("\"")
				.append("}");
		}
		jsonBuilder.append("]}");
		
		logger.trace("수업: 영화: "+jsonBuilder.toString());

		return jsonBuilder.toString();

	}
	
	@RequestMapping(value="reserve/movie", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public @ResponseBody String movieReceive(@RequestParam String movieCode, Model model) {

		
		mCode = movieCode;
		logger.trace("수업: 영화코드: "+mCode);
		
		Map<String, String> times = nservice.getNMovieTimeByThAndMovieService(thId, mCode);
		Iterator<String> iter = times.keySet().iterator();
		
		StringBuilder jsonBuilder = new StringBuilder();
		
		jsonBuilder.append("{\"times\":[");
		if(iter.hasNext()) {
			String key = iter.next();
			String value = times.get(key);
			jsonBuilder.append("{\"ampm\":")
				.append(key)
				.append(", ")
				.append("\"time\":")
				.append("\"")
				.append(value)
				.append("\"")
				.append("}");
		}
		while(iter.hasNext()) {
			jsonBuilder.append(", ");
			String key = iter.next();
			String value = times.get(key);
			jsonBuilder.append("{\"ampm\":")
				.append(key)
				.append(", ")
				.append("\"time\":")
				.append("\"")
				.append(value)
				.append("\"")
				.append("}");
		}
		jsonBuilder.append("]}");
		
		logger.trace("수업: 시간: "+jsonBuilder.toString());
		
		return jsonBuilder.toString();
	}
	
	@RequestMapping(value="reserve/time", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public @ResponseBody String timeReceive(@RequestParam String time, Model model) {
		mTime = time;
		logger.trace("수업: 영화시간: "+mTime);
		String thName = tservice.getTheaterByIdService(thId).getTheaterName();
		String mName = mservice.getMovieByMCodeService(mCode).getMovieTitleKr();
		nmId = nservice.getNMovieIdByNMovieService(thId, mCode, mTime);
		rinfo = "영화관: "+thName+", 영화: "+mName+", 시간: "+mTime;
		return rinfo;
	}

	@RequestMapping(value="/reserve/seat", method=RequestMethod.GET)
	public String reserveSeat(Model model) {
		List<SeatInfo> seats = sservice.getSInfoByNMovieIdService(nmId);
		ArrayList<Integer> seatNum = new ArrayList<Integer>();
		for (int i=0;i<seats.size();i++) {
			int num = seats.get(i).getSeatNo();
			seatNum.add(i, num);
		}
		model.addAttribute("seats", seatNum);
		model.addAttribute("rinfo", rinfo);
		return "reservation/reserv";
	}
	
	@RequestMapping(value="/reserve/payment", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public String reservePayment(@RequestParam ArrayList<String> seatlist, @RequestParam int price, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		//만약 생일이 이번달이면 쿠폰을 yes로바꾸기
		Calendar birthday = Calendar.getInstance();
		int sysmonth = birthday.MONTH+1;
		birthday.setTime(user.getUserBirthday());
		int month = birthday.MONTH+1;
		logger.trace("수업: 오늘달: "+sysmonth+"생일달: "+month);
		//쿠폰, 포인트 점수 가져오기
		seats = seatlist;
		peopleNum = seats.size();
		model.addAttribute("price", price);
		model.addAttribute("seats", seats);
		model.addAttribute("rinfo", rinfo);
		model.addAttribute("peopleNum", peopleNum);
		return "reservation/payment";
	}
	
	@RequestMapping(value="/reserve/complete", method=RequestMethod.POST)
	public String reserveComplete(HttpSession session) {
		//User user = (User) session.getAttribute("log");
		return "reservation/reservation_complete";
	}
}
