CREATE TABLE TBL_MEMBER
(
    MEMBER_ID          VARCHAR(50)  NOT NULL PRIMARY KEY,     # 회원 아이디
    MEMBER_PWD         VARCHAR(255) NOT NULL,                 # 회원 비밀번호
    NAME               VARCHAR(20)  NOT NULL,                 # 회원 이름
    EMAIL              VARCHAR(50)  NOT NULL,                 # 회원 이메일
    PHONE              VARCHAR(13)  NOT NULL,                 # 회원 전화번호
    LEVEL              VARCHAR(30) DEFAULT 'NEW',             # 회원 등급
    POINT              BIGINT      DEFAULT 0,                 # 회원 포인트
    AGREE_MARKETING_YN CHAR(1)     DEFAULT 'N',               # 마케팅 동의 여부
    ACC_INACTIVE_YN    CHAR(1)     DEFAULT 'N',               # 회원 탈퇴 여부
    TEMP_PWD_YN        CHAR(1)     DEFAULT 'N',               # 임시 비밀번호 여부
    ACC_LOGIN_COUNT    BIGINT      DEFAULT 0,                 # 로그인 횟수
    LOGIN_FAIL_COUNT   BIGINT      DEFAULT 0,                 # 로그인 실패 횟수
    LAST_LOGIN_DATE    DATETIME,                              # 마지막 로그인 날짜
    ACC_REGISTER_DATE  DATETIME    DEFAULT CURRENT_TIMESTAMP, # 회원 가입 날짜
    ACC_UPDATE_DATE    DATETIME,                              # 회원 정보 수정 날짜
    ACC_DELETE_DATE    DATETIME                               # 회원 탈퇴 날짜
);

CREATE TABLE TBL_ADDRESS
(
    ADDRESS_ID     INT AUTO_INCREMENT PRIMARY KEY,    # 주소 아이디
    MEMBER_ID      VARCHAR(50)  NOT NULL,             # 회원 아이디
    ADDRESS        VARCHAR(255) NOT NULL,             # 주소
    DETAIL_ADDRESS VARCHAR(255),                      # 상세 주소
    RECEIVER       VARCHAR(20)  NOT NULL,             # 받는 사람
    PHONE          VARCHAR(13)  NOT NULL,             # 전화번호
    REQUEST        VARCHAR(255),                      # 요청사항
    DEFAULT_YN     CHAR(1)      NOT NULL DEFAULT 'N', # 기본 배송지 여부
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_POINT
(
    POINT_ID          INT AUTO_INCREMENT PRIMARY KEY,     -- 포인트 아이디
    MEMBER_ID         VARCHAR(50)  NOT NULL,              -- 회원 아이디
    POINT_TYPE        VARCHAR(50)  NOT NULL,              -- 포인트 타입
    POINT_AMOUNT      INT          NOT NULL,              -- 포인트 금액
    POINT_DESCRIPTION VARCHAR(255) NOT NULL,              -- 포인트 지급 사유
    CREATE_POINT_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, -- 포인트 발생일
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_PRODUCT
(
    PRODUCT_ID                VARCHAR(40)  NOT NULL PRIMARY KEY,   # 상품 아이디
    MEMBER_ID                 VARCHAR(50)  NOT NULL,               # 판매자 아이디
    PRODUCT_NAME              VARCHAR(255) NOT NULL,               # 상품 이름
    PRODUCT_IMG               VARCHAR(100),                        # 상품 이미지
    PRODUCT_DESCRIPTION_IMG   VARCHAR(100),                        # 상품 설명 이미지
    PRODUCT_PRICE             INT          NOT NULL,               # 상품 가격
    PRODUCT_REGISTRATION_DATE DATETIME     NOT NULL DEFAULT NOW(), # 상품 등록 날짜
    PRODUCT_CHANGED_DATE      DATE,                                # 상품 수정 날짜
    PRODUCT_SALES_STATUS_YN   CHAR(1)      NOT NULL DEFAULT 'Y',   # 상품 판매 여부
    PRODUCT_DISCOUNT_RATE     INT          NOT NULL DEFAULT 0,     # 상품 할인율
    NUMBER_OF_PRODUCT         BIGINT       NOT NULL DEFAULT 0,     # 상품 수량
    PRODUCT_VIEWS             BIGINT       NOT NULL DEFAULT 0,     # 상품 조회수
    PRODUCT_MAIN_CATEGORY     VARCHAR(50)  NOT NULL,               # 상품 대분류 카테고리
    PRODUCT_SUB_CATEGORY      VARCHAR(50)  NOT NULL,               # 상품 소분류 카테고리
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_CART
(
    CART_ID       INT AUTO_INCREMENT PRIMARY KEY, # 장바구니 아이디
    MEMBER_ID     VARCHAR(50) NOT NULL,           # 회원 아이디
    PRODUCT_ID    VARCHAR(40) NOT NULL,           # 상품 아이디
    CART_QUANTITY INT         NOT NULL,           # 상품 수량
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE,
    FOREIGN KEY (PRODUCT_ID) REFERENCES TBL_PRODUCT (PRODUCT_ID)
);

CREATE TABLE TBL_ROLE
(
    MEMBER_ID   VARCHAR(50) NOT NULL,                     # 회원 아이디
    AUTHORITIES VARCHAR(50) NOT NULL DEFAULT 'ROLE_USER', # 권한
    PRIMARY KEY (MEMBER_ID, AUTHORITIES),
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_ADVERTISEMENTS
(
    ADVERTISEMENT_ID         VARCHAR(40) PRIMARY KEY, -- 광고 아이디
    ADVERTISEMENT_IMG        VARCHAR(100) NOT NULL,   -- 광고 이미지
    PRODUCT_ID               VARCHAR(255) NOT NULL,   -- 상품 아이디
    MEMBER_ID                VARCHAR(50)  NOT NULL,   -- 광고주
    ADVERTISEMENT_START_DATE DATE         NOT NULL,   -- 광고 시작 날짜
    ADVERTISEMENT_END_DATE   DATE         NOT NULL,   -- 광고 종료 날짜
    ADVERTISEMENT_STATUS_YN  CHAR(1)      NOT NULL,   -- 광고 상태 여부 (Y/N)
    ADVERTISEMENT_SEQUENCE   INT          NOT NULL,   -- 광고 순서
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_PRODUCT_KEYWORDS
(
    KEYWORD_ID         INT AUTO_INCREMENT PRIMARY KEY,                                -- 키워드 아이디
    PRODUCT_ID         VARCHAR(255) NOT NULL,                                         -- 상품 아이디
    KEYWORD            VARCHAR(40)  NOT NULL,                                         -- 키워드
    KEYWORD_CREATED_AT DATETIME DEFAULT CURRENT_TIMESTAMP,                            -- 키워드 생성일
    KEYWORD_DELETED_AT DATETIME DEFAULT NULL,                                         -- 키워드 삭제일
    KEYWORD_UPDATED_AT DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 키워드 수정일
);

CREATE TABLE TBL_OAUTH2_MEMBER
(
    MEMBER_ID VARCHAR(50) NOT NULL PRIMARY KEY,
    NAME      VARCHAR(50) NOT NULL,
    EMAIL     VARCHAR(50) NOT NULL
);

CREATE TABLE TBL_OAUTH2_ROLE
(
    MEMBER_ID   VARCHAR(50) NOT NULL,
    AUTHORITIES VARCHAR(50) NOT NULL,
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_OAUTH2_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_ORDER
(
    ORDER_ID        VARCHAR(40) PRIMARY KEY,                         -- 주문 ID (UUID)
    MEMBER_ID       VARCHAR(50)  NOT NULL,                           -- 회원 ID (주문자)
    ORDER_DATE      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 주문 날짜
    TOTAL_AMOUNT    INT          NOT NULL,                           -- 주문 총 금액
    PRODUCT_AMOUNT  INT          NOT NULL,                           -- 주문 총 금액
    DELIVERY_AMOUNT INT          NOT NULL,                           -- 주문 총 금액
    POSTAL_CODE     VARCHAR(10)  NOT NULL,                           -- 우편번호
    ADDRESS         VARCHAR(255) NOT NULL,                           -- 기본 주소
    ADDRESS_DETAIL  VARCHAR(255),                                    -- 상세 주소 및 상세 건물명
    RECEIVER        VARCHAR(20)  NOT NULL,                           -- 받는 사람
    PHONE           VARCHAR(15)  NOT NULL,                           -- 휴대폰 번호 (전체)
    REQUEST         VARCHAR(255),                                    -- 요청사항
    ORDER_STATUS    VARCHAR(50)  NOT NULL DEFAULT 'PENDING',         -- 주문 상태 (예: PENDING(보류), PAID(완료), CANCELED(취소))
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID)        -- 회원 ID 외래 키
);

CREATE TABLE TBL_ORDER_DETAIL
(
    ORDER_DETAIL_ID  BIGINT AUTO_INCREMENT PRIMARY KEY,          -- 주문 상세 ID
    ORDER_ID         VARCHAR(40)  NOT NULL,                      -- 주문 ID (UUID)
    PRODUCT_ID       VARCHAR(255) NOT NULL,                      -- 상품 ID
    PRODUCT_PRICE    INT          NOT NULL,                      -- 상품 가격
    QUANTITY         INT          NOT NULL,                      -- 구매 수량
    DISCOUNT_RATE    INT          NOT NULL DEFAULT 0,            -- 할인율
    TRACKING_NUMBER  VARCHAR(50)           DEFAULT NULL,         -- 운송장 번호
    PARCEL_COMPANY   VARCHAR(50)           DEFAULT NULL,         -- 택배사
    REVIEW_STATUS_YN VARCHAR(1)            DEFAULT 'N',          -- 리뷰 작성 여부 (Y/N)
    FOREIGN KEY (ORDER_ID) REFERENCES TBL_ORDER (ORDER_ID),      -- 주문 ID 외래 키
    FOREIGN KEY (PRODUCT_ID) REFERENCES TBL_PRODUCT (PRODUCT_ID) -- 상품 ID 외래 키
);

CREATE TABLE TBL_PAYMENT
(
    PAYMENT_ID          VARCHAR(40) PRIMARY KEY,                -- 결제 ID (UUID)
    ORDER_ID            VARCHAR(40) NOT NULL,                   -- 주문 ID (UUID)
    PAYMENT_AMOUNT      INT         NOT NULL,                   -- 결제 금액 (총 결제 금액)
    PAYMENT_VAT         INT,                                    -- 부가세 금액
    PAYMENT_STATUS      VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- 결제 상태 (예: PENDING, PAID, FAILED, CANCELED)
    RECEIPT_URL         VARCHAR(255),                           -- 결제 영수증 URL
    PAYMENT_METHOD_TYPE VARCHAR(50) NOT NULL,                   -- 결제 수단 타입 (예: CREDIT_CARD, BANK_TRANSFER)
    REQUESTED_AT        DATETIME,                               -- 결제 요청 시각
    PAID_AT             DATETIME,                               -- 결제 완료 시각
    FOREIGN KEY (ORDER_ID) REFERENCES TBL_ORDER (ORDER_ID)      -- 주문 ID 외래 키
);

CREATE TABLE TBL_RANKING
(
    KEYWORD        VARCHAR(255) PRIMARY KEY, -- 검색어
    RANKING        INT,                      -- 순위
    PREVIOUS_RANK  INT,                      -- 이전 순위
    RANKING_GAP    INT,                      -- 순위 변동 값
    TOTAL_SCORE    DOUBLE,                   -- 총 검색 점수
    ONE_HOUR_SCORE DOUBLE,                   -- 1시간 검색 점수
    DAILY_SCORE    DOUBLE,                   -- 일일 검색 점수
    WEEKLY_SCORE   DOUBLE,                   -- 주간 검색 점수
    TOTAL_COUNT    INT                       -- 총 검색 횟수
);

CREATE TABLE TBL_KEYWORD_LOG
(
    KEYWORD_LOG_ID BIGINT AUTO_INCREMENT PRIMARY KEY,               -- 키워드 로그 ID
    KEYWORD        VARCHAR(255) NOT NULL,                           -- 검색어
    SEARCH_DATE    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 검색 날짜
    MEMBER_ID      VARCHAR(50)                                      -- 회원 ID
);

CREATE TABLE TBL_SELLER_INQUIRY_REPLY
(
    SELLER_INQUIRY_REPLY_ID BIGINT AUTO_INCREMENT PRIMARY KEY,            -- 판매자 답변 ID
    MEMBER_ID               VARCHAR(50) NOT NULL,                         -- 회원 ID
    REPLY_CONTENTS          TEXT        NOT NULL,                         -- 답변 내용
    REPLY_DATE              DATETIME DEFAULT CURRENT_TIMESTAMP,           -- 답변 날짜
    REPLY_UPDATE_DATE       DATETIME    NULL ON UPDATE CURRENT_TIMESTAMP, -- 답변 수정 날짜
    REPLY_DELETE_DATE       DATETIME DEFAULT NULL,                        -- 답변 삭제 날짜
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_SELLER_INQUIRY
(
    SELLER_INQUIRY_ID   BIGINT AUTO_INCREMENT PRIMARY KEY,               -- 판매자 문의 ID
    PRODUCT_ID          VARCHAR(255) NOT NULL,                           -- 상품 ID
    REPLY_ID            BIGINT,                                          -- 판매자 답변 ID
    MEMBER_ID           VARCHAR(50)  NOT NULL,                           -- 회원 ID
    INQUIRY_TITLE       VARCHAR(255) NOT NULL,                           -- 문의 제목
    INQUIRY_CONTENTS    TEXT         NOT NULL,                           -- 문의 내용
    INQUIRY_DATE        DATETIME              DEFAULT CURRENT_TIMESTAMP, -- 문의 날짜
    INQUIRY_UPDATE_DATE DATETIME     NULL ON UPDATE CURRENT_TIMESTAMP,   -- 문의 수정 날짜
    INQUIRY_DELETE_DATE DATETIME              DEFAULT NULL,              -- 문의 삭제 날짜
    INQUIRY_STATUS      VARCHAR(50)  NOT NULL DEFAULT '대기중',             -- 문의 상태
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE,
    FOREIGN KEY (PRODUCT_ID) REFERENCES TBL_PRODUCT (PRODUCT_ID) ON DELETE CASCADE,
    FOREIGN KEY (REPLY_ID) REFERENCES TBL_SELLER_INQUIRY_REPLY (SELLER_INQUIRY_REPLY_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_REVIEW
(
    REVIEW_ID                        BIGINT AUTO_INCREMENT PRIMARY KEY,                           -- 독립적인 리뷰 아이디
    ORDER_DETAIL_ID                  BIGINT       NOT NULL,                                       -- 주문 상세 ID (외래 키)
    MEMBER_ID                        VARCHAR(50)  NOT NULL,                                       -- 회원 아이디
    PRODUCT_ID                       VARCHAR(255) NOT NULL,                                       -- 상품 아이디
    DETAILED_PRODUCT_REVIEW_CONTENTS TEXT,                                                        -- 상세 내용
    ONE_LINE_PRODUCT_REVIEW_CONTENTS VARCHAR(255),-- 한줄 내용
    PRODUCT_RATING                   TINYINT CHECK (PRODUCT_RATING >= 0 AND PRODUCT_RATING <= 5), -- 별점 (0~5)
    CREATED_AT                       DATETIME DEFAULT CURRENT_TIMESTAMP,-- 작성 날짜
    DELETED_AT                       DATETIME     NULL,                                           -- 삭제 날짜 (null 가능)

    -- 외래 키 설정
    CONSTRAINT FK_REVIEW_ORDER_DETAIL_ID FOREIGN KEY (ORDER_DETAIL_ID) REFERENCES TBL_ORDER_DETAIL (ORDER_DETAIL_ID) ON DELETE CASCADE,
    CONSTRAINT FK_REVIEW_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE,
    CONSTRAINT FK_REVIEW_PRODUCT_ID FOREIGN KEY (PRODUCT_ID) REFERENCES TBL_PRODUCT (PRODUCT_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_REVIEW_PHOTO
(
    REVIEW_ID BIGINT       NOT NULL, -- 리뷰 아이디
    PHOTO_URL VARCHAR(255) NOT NULL, -- 사진 URL

    -- 외래 키 설정
    CONSTRAINT FK_PHOTO_REVIEW_ID FOREIGN KEY (REVIEW_ID) REFERENCES TBL_REVIEW (REVIEW_ID) ON DELETE CASCADE
);

CREATE TABLE TBL_REVIEW_HELPFUL
(
    REVIEW_ID     BIGINT      NOT NULL, -- 리뷰 아이디
    MEMBER_ID     VARCHAR(50) NOT NULL, -- 회원 아이디
    IS_HELPFUL_YN CHAR(1)     NOT NULL, -- 도움이 되었는지 여부 (Y/N)

    -- 외래 키 설정
    CONSTRAINT FK_HELPFUL_REVIEW_ID FOREIGN KEY (REVIEW_ID) REFERENCES TBL_REVIEW (REVIEW_ID) ON DELETE CASCADE,
    CONSTRAINT FK_HELPFUL_MEMBER_ID FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE
);


## 나중에 추가하자
/*CREATE TABLE TBL_INQUIRY
(
    INQUIRY_ID  INT AUTO_INCREMENT PRIMARY KEY,                 -- 문의 ID
    MEMBER_ID   VARCHAR(50) NOT NULL,                           -- 회원 ID
    PRODUCT_ID  VARCHAR(40) NOT NULL,                           -- 상품 ID
    TITLE       VARCHAR(255) NOT NULL,                          -- 문의 제목
    CONTENT     TEXT NOT NULL,                                  -- 문의 내용
    INQUIRY_DATE DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- 문의 날짜
    INQUIRY_UPDATE_DATE DATETIME,                               -- 문의 수정 날짜
    INQUIRY_STATUS VARCHAR(50) NOT NULL DEFAULT '대기중',       -- 문의 상태
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID) ON DELETE CASCADE,
    FOREIGN KEY (PRODUCT_ID) REFERENCES TBL_PRODUCT (PRODUCT_ID) ON DELETE CASCADE
); */

INSERT INTO TBL_MEMBER (MEMBER_ID, MEMBER_PWD, NAME, EMAIL, PHONE, LAST_LOGIN_DATE, ACC_REGISTER_DATE, ACC_UPDATE_DATE)
VALUES ('user', '$2a$10$HdOg00x3nTNCO06RwdeiA.dsWWJlWLHpx9jM8qVnQp35H3cxjDfCy', '유저', 'abc@example.com',
        '010-1234-5678', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
       ('admin', '$2a$10$HdOg00x3nTNCO06RwdeiA.dsWWJlWLHpx9jM8qVnQp35H3cxjDfCy', '어드민', 'def@example.com',
        '010-1234-5678', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO TBL_ADDRESS (MEMBER_ID, ADDRESS, RECEIVER, PHONE, REQUEST, DEFAULT_YN)
VALUES ('user', '서울시 강남구 역삼동 123-456', '유저', '010-1234-5678', '문 앞에 놔주세요', 'Y'),
       ('admin', '서울시 강남구 역삼동 123-456', '어드민', '010-1234-5678', '문 앞에 놔주세요', 'Y');

INSERT INTO TBL_ROLE (MEMBER_ID, AUTHORITIES)
VALUES ('user', 'ROLE_USER'),
       ('admin', 'ROLE_USER'),
       ('admin', 'ROLE_ADMIN');

INSERT INTO TBL_PRODUCT (PRODUCT_ID, MEMBER_ID, PRODUCT_NAME, PRODUCT_IMG, PRODUCT_DESCRIPTION_IMG, PRODUCT_PRICE,
                         PRODUCT_REGISTRATION_DATE,
                         PRODUCT_CHANGED_DATE, PRODUCT_SALES_STATUS_YN, PRODUCT_DISCOUNT_RATE, NUMBER_OF_PRODUCT,
                         PRODUCT_VIEWS,
                         PRODUCT_MAIN_CATEGORY, PRODUCT_SUB_CATEGORY)
VALUES ('0ff3f590-f5b7-4521-86c7-6afbe7d4dec0', 'user', '가필드 카사바 모래 보라 굵은입자 4.55kg',
        'https://storage.googleapis.com/every_pet_img/0ff3f590-f5b7-4521-86c7-6afbe7d4dec0',
        'https://storage.googleapis.com/every_pet_img/0ff3f590-f5b7-4521-86c7-6afbe7d4dec0-description', 24900,
        '2024-06-10 00:59:41', NULL, 'Y', 0, 50, 752, 'cat', 'sand'),
       ('2375e2b0-837e-4d43-b8a9-f13090cc7c38', 'user', '비타폴 카르마 핀치 새모이',
        'https://storage.googleapis.com/every_pet_img/2375e2b0-837e-4d43-b8a9-f13090cc7c38',
        'https://storage.googleapis.com/every_pet_img/2375e2b0-837e-4d43-b8a9-f13090cc7c38-description', 13900,
        '2024-06-10 01:15:10', NULL, 'Y', 5, 1600, 42356, 'bird', 'feed'),
       ('2daec62a-e6ce-4a1e-94cd-e26d0b70c880', 'user', '두부랑 캣츠 이코노미 오리지날 7L',
        'https://storage.googleapis.com/every_pet_img/2daec62a-e6ce-4a1e-94cd-e26d0b70c880',
        'https://storage.googleapis.com/every_pet_img/2daec62a-e6ce-4a1e-94cd-e26d0b70c880-description', 7000,
        '2024-06-10 01:00:58', NULL, 'Y', 0, 30, 32667, 'cat', 'sand'),
       ('53c09767-7ae4-4b0e-b5ce-318557795d62', 'user', '뉴트리나 비스트로 4가지맛 캔 24개입',
        'https://storage.googleapis.com/every_pet_img/53c09767-7ae4-4b0e-b5ce-318557795d62',
        'https://storage.googleapis.com/every_pet_img/53c09767-7ae4-4b0e-b5ce-318557795d62-description', 26000,
        '2024-06-10 00:56:35', NULL, 'Y', 18, 600, 3456, 'cat', 'snack'),
       ('53f5f9d8-c644-4718-89c7-78f1a448cf66', 'user', '빅사이즈 솔방울 새모이 피더',
        'https://storage.googleapis.com/every_pet_img/53f5f9d8-c644-4718-89c7-78f1a448cf66',
        'https://storage.googleapis.com/every_pet_img/53f5f9d8-c644-4718-89c7-78f1a448cf66-description', 65500,
        '2024-06-10 01:17:14', NULL, 'Y', 22, 998, 3466, 'bird', 'toy'),
       ('553e2eb7-751c-4bd9-aafd-550a5429103e', 'user', '국내산 고추씨 500g 앵무새 영양간식',
        'https://storage.googleapis.com/every_pet_img/553e2eb7-751c-4bd9-aafd-550a5429103e',
        'https://storage.googleapis.com/every_pet_img/553e2eb7-751c-4bd9-aafd-550a5429103e-description', 5900,
        '2024-06-10 01:15:51', NULL, 'Y', 10, 1574, 1233, 'bird', 'snack'),
       ('55d75261-2c8f-4f2f-95e8-689b1e4e393c', 'user', '캐츠랑 전연령 20kg',
        'https://storage.googleapis.com/every_pet_img/55d75261-2c8f-4f2f-95e8-689b1e4e393c',
        'https://storage.googleapis.com/every_pet_img/55d75261-2c8f-4f2f-95e8-689b1e4e393c-description', 64000,
        '2024-06-10 00:49:34', NULL, 'Y', 18, 200, 12774, 'cat', 'feed'),
       ('58ee090a-7401-43ea-98fa-4c8c119d5f7e', 'user', '앵무새 새장 횃대 스탠드 놀이터 나무 대형',
        'https://storage.googleapis.com/every_pet_img/58ee090a-7401-43ea-98fa-4c8c119d5f7e',
        'https://storage.googleapis.com/every_pet_img/58ee090a-7401-43ea-98fa-4c8c119d5f7e-description', 32700,
        '2024-06-10 01:16:36', NULL, 'Y', 13, 298, 536, 'bird', 'toy'),
       ('775655e2-8ecd-458b-bb72-644024991032', 'user', '[소포장 1kg/5kg] 병아리사료',
        'https://storage.googleapis.com/every_pet_img/775655e2-8ecd-458b-bb72-644024991032',
        'https://storage.googleapis.com/every_pet_img/775655e2-8ecd-458b-bb72-644024991032-description', 2600,
        '2024-06-10 01:18:43', NULL, 'Y', 0, 127, 34366, 'bird', 'feed'),
       ('87bf1f0e-3d0c-4861-947a-ade64980120a', 'user', '하겐 도메스틱 버드베스 170g 앵무새 샴푸 진드게 제거 새용품 앵무새용품',
        'https://storage.googleapis.com/every_pet_img/87bf1f0e-3d0c-4861-947a-ade64980120a',
        'https://storage.googleapis.com/every_pet_img/87bf1f0e-3d0c-4861-947a-ade64980120a-description', 19500,
        '2024-06-10 01:21:38', NULL, 'Y', 4, 78, 43, 'bird', 'beauty'),
       ('87d5a8e7-7b32-4f40-ac79-9d884eeca0a9', 'user', '퓨리나 프리스키 파티믹스 오리지날 60g',
        'https://storage.googleapis.com/every_pet_img/87d5a8e7-7b32-4f40-ac79-9d884eeca0a9',
        'https://storage.googleapis.com/every_pet_img/87d5a8e7-7b32-4f40-ac79-9d884eeca0a9-description', 6000,
        '2024-06-10 00:54:57', NULL, 'Y', 8, 2100, 9821, 'cat', 'snack'),
       ('8fa5755d-0c55-4e17-84b2-b45eb01e2608', 'user', '프로베스트 캣 블루 20kg',
        'https://storage.googleapis.com/every_pet_img/8fa5755d-0c55-4e17-84b2-b45eb01e2608',
        'https://storage.googleapis.com/every_pet_img/8fa5755d-0c55-4e17-84b2-b45eb01e2608-description', 62000,
        '2024-06-10 00:51:07', NULL, 'Y', 11, 350, 23, 'cat', 'feed'),
       ('91812da7-65a9-4b14-afca-67a9355d4238', 'user', '이나바 챠오 츄르 참치 4개입, 4개 묶음',
        'https://storage.googleapis.com/every_pet_img/91812da7-65a9-4b14-afca-67a9355d4238',
        'https://storage.googleapis.com/every_pet_img/91812da7-65a9-4b14-afca-67a9355d4238-description', 12000,
        '2024-06-10 00:53:12', NULL, 'Y', 5, 1400, 4556, 'cat', 'snack'),
       ('9d18fb59-e6dc-4bb1-b8b7-959ca523419d', 'user', '오리젠 오리지널 캣 5.4kg',
        'https://storage.googleapis.com/every_pet_img/9d18fb59-e6dc-4bb1-b8b7-959ca523419d',
        'https://storage.googleapis.com/every_pet_img/9d18fb59-e6dc-4bb1-b8b7-959ca523419d-description', 93000,
        '2024-06-10 01:05:54', NULL, 'Y', 0, 5, 567, 'cat', 'feed'),
       ('9dbd81ad-a380-4848-bdc1-3d7ed3ad90b5', 'user', '스테인리스 대형새장 앵무세 케이지 날림장',
        'https://storage.googleapis.com/every_pet_img/9dbd81ad-a380-4848-bdc1-3d7ed3ad90b5',
        'https://storage.googleapis.com/every_pet_img/9dbd81ad-a380-4848-bdc1-3d7ed3ad90b5-description', 39900,
        '2024-06-10 01:17:51', NULL, 'Y', 26, 12, 3454, 'bird', 'cage'),
       ('9e62772a-ed6e-4502-84e2-6e032737bdc6', 'user', '트릭시 나무롤링 앵무새 장난감 천연 목재 장구방울',
        'https://storage.googleapis.com/every_pet_img/9e62772a-ed6e-4502-84e2-6e032737bdc6',
        'https://storage.googleapis.com/every_pet_img/9e62772a-ed6e-4502-84e2-6e032737bdc6-description', 3500,
        '2024-06-10 01:20:55', NULL, 'Y', 3, 988, 4367, 'bird', 'toy'),
       ('a17950cd-518c-4ecd-a3c8-73da170b42aa', 'user', '리오 영양 비스킷 깃털건강 5P 앵무새 간식 ',
        'https://storage.googleapis.com/every_pet_img/a17950cd-518c-4ecd-a3c8-73da170b42aa',
        'https://storage.googleapis.com/every_pet_img/a17950cd-518c-4ecd-a3c8-73da170b42aa-description', 4600,
        '2024-06-10 01:19:22', NULL, 'Y', 0, 288, 567, 'bird', 'snack'),
       ('ade83186-67ce-40ad-aff5-f08fcb504e15', 'user', '로얄캐닌 인도어 4kg 변냄새 감소',
        'https://storage.googleapis.com/every_pet_img/ade83186-67ce-40ad-aff5-f08fcb504e15',
        'https://storage.googleapis.com/every_pet_img/ade83186-67ce-40ad-aff5-f08fcb504e15-description', 72000,
        '2024-06-10 00:45:29', NULL, 'Y', 25, 100, 1438, 'cat', 'feed'),
       ('bb0172da-83f7-4e78-a922-657f37bab888', 'user', '레토 박스형 화장실 65cm 특대형',
        'https://storage.googleapis.com/every_pet_img/bb0172da-83f7-4e78-a922-657f37bab888',
        'https://storage.googleapis.com/every_pet_img/bb0172da-83f7-4e78-a922-657f37bab888-description', 29900,
        '2024-06-10 01:04:04', NULL, 'Y', 29, 90, 234, 'cat', 'restroom'),
       ('d3174dd0-12b0-4fcc-80fa-20d03f0577fa', 'user', '베트남 접시둥지(소) 앵무새 둥지',
        'https://storage.googleapis.com/every_pet_img/d3174dd0-12b0-4fcc-80fa-20d03f0577fa',
        'https://storage.googleapis.com/every_pet_img/d3174dd0-12b0-4fcc-80fa-20d03f0577fa-description', 2900,
        '2024-06-10 01:14:31', NULL, 'Y', 1, 600, 416, 'bird', 'cage'),
       ('d4f59e0e-f3d0-49c9-85aa-2ab11d88fe9f', 'user', '넥톤 S 330g 앵무새 비타민 영양제 면역력강화 편식예방 종합영양제',
        'https://storage.googleapis.com/every_pet_img/d4f59e0e-f3d0-49c9-85aa-2ab11d88fe9f',
        'https://storage.googleapis.com/every_pet_img/d4f59e0e-f3d0-49c9-85aa-2ab11d88fe9f-description', 91900,
        '2024-06-10 01:20:14', NULL, 'Y', 10, 88, 7, 'bird', 'health'),
       ('ee53c40e-1ab5-4793-a7b9-e1b35e18dff3', 'user', '사각앵무새장 무지개은신처',
        'https://storage.googleapis.com/every_pet_img/ee53c40e-1ab5-4793-a7b9-e1b35e18dff3',
        'https://storage.googleapis.com/every_pet_img/ee53c40e-1ab5-4793-a7b9-e1b35e18dff3-description', 48900,
        '2024-06-10 01:13:49', NULL, 'Y', 5, 500, 230, 'bird', 'cage'),
       ('1f7832af-e587-495e-bf00-b14f9f3bf137', 'user', '주트립 조인트 컨트롤 시니어 (7세 이상) (관절 건강에 좋은 강아지 기능성 사료)',
        'https://storage.googleapis.com/every_pet_img/1f7832af-e587-495e-bf00-b14f9f3bf137',
        'https://storage.googleapis.com/every_pet_img/1f7832af-e587-495e-bf00-b14f9f3bf137-description', 30000,
        '2024-06-10 00:56:34', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('34913009-d6b8-4403-9e78-21e8eed07d34', 'user', '페츠베리머치 알러지 앤 티어스테인 케어 (연어) 사료 1kg',
        'https://storage.googleapis.com/every_pet_img/34913009-d6b8-4403-9e78-21e8eed07d34',
        'https://storage.googleapis.com/every_pet_img/34913009-d6b8-4403-9e78-21e8eed07d34-description', 39000,
        '2024-06-10 01:13:23', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('353f4573-9af6-4296-a297-506112f3680d', 'user', '프라임 밸런스 15kg 대용량 강아지사료 대형견 중형견 소형견 전연령 성견 뉴트리',
        'https://storage.googleapis.com/every_pet_img/353f4573-9af6-4296-a297-506112f3680d',
        'https://storage.googleapis.com/every_pet_img/353f4573-9af6-4296-a297-506112f3680d-description', 70000,
        '2024-06-10 01:10:15', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('41bc6a7a-bbea-4cbe-9001-a8fe0ba3daed', 'user', '지위픽 독 소고기 1kg',
        'https://storage.googleapis.com/every_pet_img/41bc6a7a-bbea-4cbe-9001-a8fe0ba3daed',
        'https://storage.googleapis.com/every_pet_img/41bc6a7a-bbea-4cbe-9001-a8fe0ba3daed-description', 20000,
        '2024-06-10 01:02:08', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('800f0f28-1947-49bd-bb48-ccfaadaad760', 'user', '로얄캐닌 강아지사료 푸들 어덜트 3kg + 샘플2개',
        'https://storage.googleapis.com/every_pet_img/800f0f28-1947-49bd-bb48-ccfaadaad760',
        'https://storage.googleapis.com/every_pet_img/800f0f28-1947-49bd-bb48-ccfaadaad760-description', 60000,
        '2024-06-10 01:08:31', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('89f4597f-b459-4c1c-a2d5-e956ad083af7', 'user', '프라임 퍼포먼스 플러스 20kg 대형견 사료 대용량 강아지사료',
        'https://storage.googleapis.com/every_pet_img/89f4597f-b459-4c1c-a2d5-e956ad083af7',
        'https://storage.googleapis.com/every_pet_img/89f4597f-b459-4c1c-a2d5-e956ad083af7-description', 49999,
        '2024-06-10 01:11:12', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('a49e922f-3196-488c-93c6-635b6877413c', 'user', '시저 건사료 1kgx2개 골라담기+물티슈1팩',
        'https://storage.googleapis.com/every_pet_img/a49e922f-3196-488c-93c6-635b6877413c',
        'https://storage.googleapis.com/every_pet_img/a49e922f-3196-488c-93c6-635b6877413c-description', 10000,
        '2024-06-10 01:09:21', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('ba48fb59-c0cd-40ec-98f2-ce6385ded8eb', 'user', '힐스 강아지사료 어덜트 라이트 스몰포 1.5kg',
        'https://storage.googleapis.com/every_pet_img/ba48fb59-c0cd-40ec-98f2-ce6385ded8eb',
        'https://storage.googleapis.com/every_pet_img/ba48fb59-c0cd-40ec-98f2-ce6385ded8eb-description', 50000,
        '2024-06-10 00:54:15', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('c5b2cf0a-07e9-4b78-a915-1456aca46a47', 'user', '프라임 퍼포먼스 20kg 대용량 강아지사료 대형견 큰개 특수견 진도 뉴트리나',
        'https://storage.googleapis.com/every_pet_img/c5b2cf0a-07e9-4b78-a915-1456aca46a47',
        'https://storage.googleapis.com/every_pet_img/c5b2cf0a-07e9-4b78-a915-1456aca46a47-description', 90000,
        '2024-06-10 01:12:08', NULL, 'Y', 0, 5, 0, 'dog', 'feed'),
       ('fbe9f994-2a81-439d-9974-5f802fe10b98', 'user', '보노네이처 강아지 인도어(면역&체중) & 스킨앤코트(피부&모질)',
        'https://storage.googleapis.com/every_pet_img/fbe9f994-2a81-439d-9974-5f802fe10b98',
        'https://storage.googleapis.com/every_pet_img/fbe9f994-2a81-439d-9974-5f802fe10b98-description', 40000,
        '2024-06-10 01:07:12', NULL, 'Y', 0, 5, 0, 'dog', 'feed');


INSERT INTO TBL_ADVERTISEMENTS
(`ADVERTISEMENT_ID`, `ADVERTISEMENT_IMG`, `PRODUCT_ID`, `MEMBER_ID`, `ADVERTISEMENT_START_DATE`,
 `ADVERTISEMENT_END_DATE`, `ADVERTISEMENT_STATUS_YN`, `ADVERTISEMENT_SEQUENCE`)
VALUES ('17cba5c4-ba63-4288-bd40-f9b20f739d84',
        'https://storage.googleapis.com/every_pet_img/17cba5c4-ba63-4288-bd40-f9b20f739d84',
        '0ff3f590-f5b7-4521-86c7-6afbe7d4dec0', 'admin', '2024-01-01', '2025-01-01', 'Y', 1),
       ('6c436bbc-32a8-4453-b88b-a23a9bfdeaa6',
        'https://storage.googleapis.com/every_pet_img/6c436bbc-32a8-4453-b88b-a23a9bfdeaa6',
        '1f7832af-e587-495e-bf00-b14f9f3bf137', 'admin', '2024-01-01', '2025-01-01', 'Y', 2),
       ('fd36c1da-1157-48f6-b8a3-dfdbe58d0ed8',
        'https://storage.googleapis.com/every_pet_img/fd36c1da-1157-48f6-b8a3-dfdbe58d0ed8',
        '2375e2b0-837e-4d43-b8a9-f13090cc7c38', 'admin', '2024-01-01', '2025-01-01', 'Y', 3);


INSERT INTO TBL_ADDRESS (MEMBER_ID, ADDRESS, DETAIL_ADDRESS, RECEIVER, PHONE, REQUEST, DEFAULT_YN)
VALUES ('user', '서울특별시 강남구 테헤란로', '105-1505', '홍길동', '010-1234-5678', '문 앞에 두고 벨 눌러주세요.', 'Y');

INSERT INTO TBL_RANKING (KEYWORD, RANKING, PREVIOUS_RANK, RANKING_GAP, TOTAL_SCORE, ONE_HOUR_SCORE, DAILY_SCORE,
                         WEEKLY_SCORE, TOTAL_COUNT)
VALUES ('자동차', 1, 53, 52, 1000.0, 100.0, 500.0, 800.0, 7511),
       ('영화', 2, 8, 6, 955.47, 97.83, 480.31, 777.16, 8256),
       ('음식', 3, 1, -2, 958.39, 95.75, 466.48, 720.0, 7612),
       ('여행', 4, 80, 76, 949.94, 98.87, 463.29, 724.11, 7812),
       ('커피', 5, 3, -2, 946.0, 86.52, 435.95, 788.85, 8612),
       ('도서', 6, 40, 34, 756.26, 96.8, 445.57, 636.55, 5217),
       ('스포츠', 7, 10, 3, 809.07, 89.23, 393.41, 762.21, 9534),
       ('음악', 8, 1, -7, 658.22, 81.91, 351.82, 775.37, 5571),
       ('패션', 9, 40, 31, 843.81, 66.54, 489.91, 636.19, 6332),
       ('기술', 10, 86, 76, 623.55, 98.95, 449.63, 542.42, 8491),
       ('건강', 11, 36, 25, 702.9, 62.81, 306.99, 526.13, 8888),
       ('쇼핑', 12, 98, 86, 549.0, 81.01, 266.5, 522.77, 9759),
       ('교육', 13, 40, 27, 773.94, 73.48, 321.75, 540.99, 6142),
       ('게임', 14, 20, 6, 703.14, 74.15, 350.97, 698.03, 8452),
       ('날씨', 15, 18, 3, 446.53, 93.27, 369.95, 332.61, 9195),
       ('뉴스', 16, 53, 37, 979.5, 40.5, 225.88, 369.86, 9474),
       ('경제', 17, 82, 65, 251.05, 37.13, 346.81, 624.69, 7090),
       ('정치', 18, 59, 41, 374.24, 73.98, 363.38, 627.32, 9897),
       ('사회', 19, 4, -15, 449.95, 57.73, 204.97, 264.35, 7268),
       ('문화', 20, 13, -7, 168.58, 54.39, 496.07, 411.17, 6199);
