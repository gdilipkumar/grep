package com.imaginea.dilip.grep.entities;

public class State {

	public static final char JOIN = 256;
	public static final char SPLIT = 257;
	public static final char ANY = 255;

	private final char ch;
	private State out;
	private State out1;
	private int lastLink;

	public State(char ch) {
		this.ch = ch;
		this.out = null;
		this.out1 = null;
		this.lastLink = 0;
	}

	public State getOut() {
		return out;
	}

	public void setOut(State out) {
		this.out = out;
	}

	public State getOut1() {
		return out1;
	}

	public void setOut1(State out1) {
		this.out1 = out1;
	}

	public int getLastLink() {
		return lastLink;
	}

	public void setLastLink(int lastLink) {
		this.lastLink = lastLink;
	}

	public int getCh() {
		return ch;
	}
}
