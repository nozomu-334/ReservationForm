package com.example.reservation;

import java.time.LocalDateTime;

public class Reservation {

	private int id;
	private String name;
	private LocalDateTime reservationTime;
	private int numberOfPeople;
	private String seats; // 追加: 選択した席の情報

	public Reservation(int id, String name, LocalDateTime reservationTime, int numberOfPeople, String seats) {
		this.id = id;
		this.name = name;
		this.reservationTime = reservationTime;
		this.numberOfPeople = numberOfPeople;
		this.seats = seats;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public LocalDateTime getReservationTime() {
		return reservationTime;
	}

	public int getNumberOfPeople() {
		return numberOfPeople;
	}

	public String getSeats() {
		return seats;
	}
}