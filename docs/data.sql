CREATE TABLE TBL_MEMBER
(
    MEMBER_ID          VARCHAR(50)  NOT NULL PRIMARY KEY,
    MEMBER_PWD         VARCHAR(255) NOT NULL,
    NAME               VARCHAR(20)  NOT NULL,
    EMAIL              VARCHAR(50)  NOT NULL,
    PHONE              VARCHAR(13)  NOT NULL,
    LEVEL              VARCHAR(30) DEFAULT 'NEW',
    POINT              BIGINT      DEFAULT 0,
    AGREE_MARKETING_YN CHAR(1)     DEFAULT 'N',
    ACC_INACTIVE_YN    CHAR(1)     DEFAULT 'N',
    TEMP_PWD_YN        CHAR(1)     DEFAULT 'N',
    ACC_LOGIN_COUNT    BIGINT      DEFAULT 0,
    LOGIN_FAIL_COUNT   BIGINT      DEFAULT 0,
    LAST_LOGIN_DATE    DATETIME,
    ACC_REGISTER_DATE  DATETIME    DEFAULT CURRENT_TIMESTAMP,
    ACC_UPDATE_DATE    DATETIME,
    ACC_DELETE_DATE    DATETIME
);

CREATE TABLE TBL_ADDRESS
(
    ADDRESS_NO BIGINT       NOT NULL AUTO_INCREMENT,
    MEMBER_ID  VARCHAR(20)  NOT NULL,
    ADDRESS    VARCHAR(255) NOT NULL,
    RECEIVER   VARCHAR(20)  NOT NULL,
    PHONE      VARCHAR(13)  NOT NULL,
    REQUEST    VARCHAR(255),
    DEFAULT_YN CHAR(1)      NOT NULL DEFAULT 'N',
    PRIMARY KEY (ADDRESS_NO),
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID)
);

CREATE TABLE TBL_ROLE
(
    MEMBER_ID   VARCHAR(50) NOT NULL,
    AUTHORITIES VARCHAR(50) NOT NULL,
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_MEMBER (MEMBER_ID)
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
    FOREIGN KEY (MEMBER_ID) REFERENCES TBL_OAUTH2_MEMBER (MEMBER_ID)
);

INSERT INTO TBL_MEMBER (MEMBER_ID, MEMBER_PWD, NAME, EMAIL, PHONE, LAST_LOGIN_DATE, ACC_REGISTER_DATE, ACC_UPDATE_DATE)
VALUES ('user', '$2a$10$HdOg00x3nTNCO06RwdeiA.dsWWJlWLHpx9jM8qVnQp35H3cxjDfCy', 'John Doe', 'abc@example.com', '010-1234-5678', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO TBL_ROLE (MEMBER_ID, AUTHORITIES)
VALUES ('user', 'ROLE_USER');
