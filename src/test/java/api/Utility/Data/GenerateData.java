package api.Utility.Data;

public class GenerateData {
	
	public static String getEmail() {
		String prefix ="instructor_email";
		String provider = "@tekschool.us";
		
		//"Auto_email12312@tekschool.us"
		int random = (int)(Math.random() * 10000);
		String email = prefix+ random+ provider;
		
		return email;
	}
	
//	public static void main(String[] args) {
//		GenerateData data = new GenerateData();
//		System.out.println(data.getEmail());
//		
//	}
	/*
	 * Generate Random Phone number of 10 digits
	 * @return String random phone number
	 * 
	 */
	public static String getPhoneNumber() {
		String phoneNumber = "2";
		for (int i=0; i<9; i++ ) {
			phoneNumber += (int) (Math.random()* 10);
		}
		return phoneNumber;	
	}
	
	public static void main(String [] args) {
		String number = getPhoneNumber();
		System.out.println(number);
		System.out.println(number.length());
	}

}
