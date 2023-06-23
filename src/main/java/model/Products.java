package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class Products {
	String productName, productBrand, 
	productCategory, productDescription, productImage;
	int productID, productStock;
	float productPrice;
	
	public Products() {}
	
	public Products(int productID, String productName, float productPrice, int productStock, String productBrand, 
			 String productCategory, String productDescription, String productImage) {
		this.productID= productID;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productStock = productStock;
		this.productBrand = productBrand;
		this.productCategory = productCategory;
		this.productDescription = productDescription;
		this.productImage = productImage;
	}
	
	public Products(String productName, float productPrice, int productStock, String productBrand, 
			 String productCategory, String productDescription, Part part) {
		this.productName = productName;
		this.productPrice = productPrice;
		this.productStock = productStock;
		this.productBrand = productBrand;
		this.productCategory = productCategory;
		this.productDescription = productDescription;
		this.productImage = getImageUrl(part);
	}
	
	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	
	private String getImageUrl(Part part) {
		String savePath = MyConstants.PRODIMGSAVEPATH;
		File fileSaveDir = new File(savePath);
		String productImage = null;
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				productImage = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		if(productImage == null || productImage.isEmpty()) {
			productImage= "download.png";
		}
		return productImage;
	}

	public String getProductImage() {
		return productImage;
	}
	
	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public void setProductImage(Part part) {
		this.productImage = getImageUrl(part);
	}

	public float getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(float productPrice) {
		this.productPrice = productPrice;
	}
	public int getProductStock() {
		return productStock;
	}

	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}
	
}	
