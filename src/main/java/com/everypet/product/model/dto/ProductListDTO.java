package com.everypet.product.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductListDTO {
    private String productId; // 상품 아이디
    private String memberId; // 판매자 아이디
    private String name; // 판매자 이름
    private String productImg; // 상품 이미지
    private String productDescriptionImg; // 상품 설명 이미지
    private String productName; // 상품 이름
    private int productPrice; // 상품 가격
    private int productDiscountRate; // 상품 할인율
    private String productRegistrationDate; // 상품 등록 날짜
    private long productViews; // 상품 조회수
    private String productMainCategory; // 상품 대분류 카테고리
    private String productSubCategory; // 상품 소분류 카테고리
    private double productRatingAvg; // 리뷰 평점 평균
    private int reviewCount; // 리뷰 개수
    private int numberOfProduct; // 상품 수량
    private String productSalesStatusYN; // 상품 판매 상태
    private int salesCount; // 판매 개수
}
