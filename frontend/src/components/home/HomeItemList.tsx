import React from 'react';
import { Product } from "../../typings/product";
import LoadingSpinner from "../../utils/reactQuery/LoadingSpinner";
import ErrorComponent from "../../utils/reactQuery/ErrorComponent";
import Item from "../product/Item";
import axios from "axios";
import NotFoundProduct from "../../utils/reactQuery/NotFoundProduct";
import { useQuery } from "@tanstack/react-query";
import { API_URL } from "../../api/api";
import styles from './HomeItemList.module.css'; // CSS 모듈 사용

const HomeItemList = ({ brandName }: { brandName: string }) => {
    const orderBy = 'popularity';
    const page = 1;
    const pageSize = 8;

    const fetchItems = async (): Promise<Product[]> => {
        const response = await axios.get(`${API_URL}/product/search/${brandName}/${orderBy}/${page}/${pageSize}`);
        return response.data;
    };

    const {
        data: product,
        error,
        isPending
    } = useQuery<Product[], Error>({
        queryKey: [brandName],
        queryFn: fetchItems,
    });

    if (isPending) {
        return <LoadingSpinner />;
    }

    if (error) {
        return <ErrorComponent message={error.message} />;
    }

    return (
        <>
            {product && product.length > 0 ? (
                <div className={styles.container}>
                    {product.map((item) => (
                        <Item
                            key={item.productId}
                            productId={item.productId}
                            name={item.productName}
                            price={item.productPrice}
                            discount={item.productDiscountRate}
                            recommended={item.productViews}
                            reviewCount={item.numberOfProduct}
                            imageUrl={`https://storage.googleapis.com/every_pet_img/${item.productId}`}
                        />
                    ))}
                </div>
            ) : (
                <NotFoundProduct />
            )}
        </>
    );
};

export default HomeItemList;
