-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    customerid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customerid)
        REFERENCES public.customers (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_orders_product FOREIGN KEY (productid)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;


DO $$
DECLARE
    i INTEGER;
    customer_id INTEGER;
    product_id INTEGER;
    qty INTEGER;
BEGIN
    FOR i IN 1..342 LOOP
        customer_id := i;
        product_id := ((i - 1) % 10) + 1;
        qty := ((i + 1) % 4) + 1;

        INSERT INTO public.orders (
            customerid,
            productid,
            quantity
        )
        VALUES (
            customer_id,
            product_id,
            qty
        );
    END LOOP;
END $$;
