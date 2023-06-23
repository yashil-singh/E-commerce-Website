package model;

public class Categories {
	String productCategory;
	
	public Categories () {}
	
	public Categories (String productCategory) {
		this.productCategory = productCategory;
	}	
	
	public String getCategory() {
		return productCategory;
	}
	public void setCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	
}

