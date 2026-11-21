-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(150) COLLATE pg_catalog."default" NOT NULL,
    email character varying(200) COLLATE pg_catalog."default" NOT NULL,
    status character varying(30) COLLATE pg_catalog."default" NOT NULL,
    datejoined date NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (id),
    CONSTRAINT customers_email_key UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;


DO $$
DECLARE
    i INTEGER;
    first_names TEXT[] := ARRAY[
    'Alex', 'Jordan', 'Taylor', 'Morgan', 'Casey',
    'Riley', 'Jamie', 'Avery', 'Cameron', 'Drew',
    'Logan', 'Parker', 'Quinn', 'Reese', 'Skyler',
    'Dakota', 'Emerson', 'Finley', 'Harper', 'Hayden',
    'Jesse', 'Kendall', 'Lane', 'Micah', 'Noah',
    'Payton', 'Juan', 'Sage', 'Shawn', 'Sydney',
    'Blake', 'Charlie', 'Devon', 'Elliot', 'Frankie',
    'Gray', 'Adrian', 'Amelia', 'Benjamin', 'Bianca',
    'Carlos', 'Daniel', 'Elena', 'Gabriel', 'Isabella',
    'Javier', 'Lucia', 'Mateo', 'Natalia', 'Oliver',
    'Sofia', 'Sebastian', 'Valentina', 'Xavier', 'Camila',
    'Diego', 'Emilio', 'Fernando', 'Ismael', 'Juliana',
    'Leonardo', 'Mariana', 'Nicolas', 'Rafael', 'Samuel',
    'Andrea', 'Brandon', 'Cristina', 'Eduardo', 'Felicia',
    'Giselle', 'Hector', 'Ivan', 'Jose', 'Kevin',
    'Laura', 'Manuel', 'Melissa', 'Oscar', 'Patricia',
    'Roberto', 'Teresa', 'Victor', 'William', 'Yolanda',
    'Aaron', 'Bella', 'Christopher', 'Diana', 'Eric',
    'Fatima', 'George', 'Hannah', 'Isaac', 'Julia',
    'Kyle', 'Lillian', 'Marcus', 'Vanessa', 'Zachary'
];


    last_names TEXT[] := ARRAY[
    'Anderson', 'Bennett', 'Carter', 'Dawson', 'Edwards',
    'Foster', 'Garcia', 'Harrison', 'Jackson', 'Kennedy',
    'Lewis', 'Mitchell', 'Nelson', 'Owens', 'Patterson',
    'Quinn', 'Roberts', 'Stewart', 'Turner', 'Underwood',
    'Vargas', 'Mendez', 'Young', 'Zimmerman', 'Adams',
    'Brooks', 'Collins', 'Diaz', 'Evans', 'Flores',
    'Gonzales', 'Hughes', 'James', 'King', 'Lopez',
    'Martinez', 'Alvarez', 'Baker', 'Castillo', 'Delgado',
    'Espinoza', 'Fernandez', 'Gutierrez', 'Herrera', 'Ibarra',
    'Jimenez', 'Keller', 'Luna', 'Morales', 'Navarro',
    'Ortega', 'Perez', 'Ramirez', 'Salazar', 'Torres',
    'Valdez', 'White', 'Acosta', 'Barrett', 'Campos',
    'Dominguez', 'Estrada', 'Fuentes', 'Gallagher', 'Holland',
    'Ingram', 'Jefferson', 'Garza', 'Lawson', 'Mendoza',
    'Nichols', 'Ochoa', 'Palacios', 'Reynolds', 'Santiago',
    'Trujillo', 'Upton', 'Vasquez', 'Wheeler', 'York',
    'Zamora', 'Baldwin', 'Caldwell', 'Donovan', 'Ellison',
    'Figueroa', 'Griffin', 'Henderson', 'Irwin', 'Johnston',
    'Klein', 'Larsen', 'Montgomery', 'Newman', 'Pacheco',
    'Richards', 'Sandoval', 'Valentine', 'West', 'Zuniga'
];

BEGIN
    FOR i IN 1..1284 LOOP

        INSERT INTO public.customers (
            name,
            email,
            status,
            datejoined
        )
        VALUES (
            first_names[((i - 1) % 100) + 1] || ' ' ||
                last_names[((i - 1) / 100) + 1],

            LOWER(
                first_names[((i - 1) % 100) + 1] || '.' ||
                last_names[((i - 1) / 100) + 1] ||
                i || '@utrgv.edu'
            ),

            CASE
                WHEN random() < 0.8 THEN 'active'
                ELSE 'inactive'
            END,

            DATE '2023-01-01' +
                FLOOR(random() * 1419)::INTEGER
        );

    END LOOP;
END $$;
