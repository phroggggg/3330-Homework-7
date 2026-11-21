-- Table: public.sales

-- DROP TABLE IF EXISTS public.sales;

CREATE TABLE IF NOT EXISTS public.sales
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    productid integer NOT NULL,
    quantity integer NOT NULL,
    saleamount numeric(12,2) NOT NULL,
    CONSTRAINT sales_pkey PRIMARY KEY (id),
    CONSTRAINT fk_sales_product FOREIGN KEY (productid)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales
    OWNER to postgres;


INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (1, 5, 6000.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (2, 10, 8000.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (3, 9, 4050.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (4, 25, 7500.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (5, 42, 4200.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (6, 30, 1500.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (7, 20, 3000.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (8, 1, 250.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (9, 3, 300.00);

INSERT INTO public.sales (productid, quantity, saleamount)
VALUES (10, 5, 1000.00);
