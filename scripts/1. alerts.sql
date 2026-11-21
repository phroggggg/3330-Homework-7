-- Table: public.alerts

-- DROP TABLE IF EXISTS public.alerts;

CREATE TABLE IF NOT EXISTS public.alerts
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type character varying(30) COLLATE pg_catalog."default" NOT NULL,
    description character varying(500) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT alerts_pkey PRIMARY KEY (id),
    CONSTRAINT ck_alerts_type CHECK (type::text = ANY (ARRAY['issues'::character varying, 'notifications'::character varying, 'tasks'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.alerts
    OWNER to postgres;

INSERT INTO public.alerts (type, description)
VALUES
('issues', 'Low inventory detected for Laptop'),
('issues', 'Payment processing failure'),
('issues', 'Customer account verification failed'),
('issues', 'Order fulfillment delayed'),
('issues', 'Product inventory mismatch'),
('issues', 'Failed transaction detected'),
('issues', 'Customer email delivery failed'),
('issues', 'Product price discrepancy'),
('issues', 'Order cancellation requires review'),
('issues', 'Low inventory detected for Monitor'),
('issues', 'Sales report data inconsistency'),
('issues', 'Customer account requires attention'),
('notifications', 'New customer registered'),
('notifications', 'Monthly sales report generated'),
('notifications', 'New order successfully received'),
('tasks', 'Review pending customer orders'),
('tasks', 'Update product inventory'),
('tasks', 'Generate monthly revenue report');