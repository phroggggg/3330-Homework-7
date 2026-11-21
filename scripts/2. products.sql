-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(150) COLLATE pg_catalog."default" NOT NULL,
    price numeric(12,2) NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;


INSERT INTO public.products (name, price, quantity)
VALUES ('Laptop', 1200.00, 50);

INSERT INTO public.products (name, price, quantity)
VALUES ('Smartphone', 800.00, 100);

INSERT INTO public.products (name, price, quantity)
VALUES ('Tablet', 450.00, 75);

INSERT INTO public.products (name, price, quantity)
VALUES ('Monitor', 300.00, 60);

INSERT INTO public.products (name, price, quantity)
VALUES ('Keyboard', 100.00, 150);

INSERT INTO public.products (name, price, quantity)
VALUES ('Mouse', 50.00, 200);

INSERT INTO public.products (name, price, quantity)
VALUES ('Headphones', 150.00, 100);

INSERT INTO public.products (name, price, quantity)
VALUES ('Printer', 250.00, 40);

INSERT INTO public.products (name, price, quantity)
VALUES ('Webcam', 100.00, 80);

INSERT INTO public.products (name, price, quantity)
VALUES ('External Drive', 200.00, 90);
