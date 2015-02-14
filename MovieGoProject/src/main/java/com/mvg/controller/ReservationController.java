package com.mvg.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mvg.entity.NowMovie;
import com.mvg.entity.Theater;
import com.mvg.service.NowMovieService;
import com.mvg.service.ReservationService;
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
	NowMovieService nService;
	
	
	/*@RequestMapping(value="/reserve",  method=RequestMethod.GET)
	public String reserve(Model model){
		List<Theater> theaters = tservice.getAllTheatersService();
		model.addAttribute("theaters", theaters);
		List<NowMovie> nowmovies = nService.getAllNMoviesService();
		model.addAttribute("nowmovies", nowmovies);
		return "reservation/reservation1";
	}
	*/
	
}
