package com.imaginea.dilip.grep.searcher;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SearcherJavaImpl implements TextSearcher {
	private Pattern pattern;

	public SearcherJavaImpl(String searchKey, boolean caseInSensitive) {
		if (caseInSensitive) {
			this.pattern = Pattern.compile(searchKey, Pattern.CASE_INSENSITIVE);
		} else {
			this.pattern = Pattern.compile(searchKey, Pattern.CASE_INSENSITIVE);
		}
	}

	static List<String> searchString(String searchKey, String string) {
		List<String> result = new ArrayList<String>();
		String[] tokens = string.split(System.lineSeparator());

		for (int i = 0; i < tokens.length; i++) {
			if (tokens[i].contains(searchKey)) {
				result.add(tokens[i]);
			}
		}

		return result;
	}

	public boolean isStringContains(String sString) {
		Matcher matcher = pattern.matcher(sString);
		return matcher.find();
	}
}
