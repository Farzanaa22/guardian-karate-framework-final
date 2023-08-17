package api.runner;

import com.intuit.karate.junit5.Karate;

public class RegressionRunner {
	
	@Karate.Test
	public Karate runTest() {
		//address for our feature files
		//And tags
		return Karate.run("classpath:features")
				.tags("Regression");
	}

}
