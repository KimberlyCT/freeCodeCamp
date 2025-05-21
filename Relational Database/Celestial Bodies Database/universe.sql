--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(20) NOT NULL,
    distance_from_earth_mly numeric(6,4) NOT NULL,
    satellite_galaxy boolean,
    galaxy_type character varying(20) NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: galaxy_other_info; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_other_info (
    galaxy_other_info_id integer NOT NULL,
    name character varying(20) NOT NULL,
    also_known_as character varying(20) NOT NULL,
    constellation character varying(20) NOT NULL,
    description text,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.galaxy_other_info OWNER TO freecodecamp;

--
-- Name: galaxy_other_info_galaxy_other_info_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_other_info_galaxy_other_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_other_info_galaxy_other_info_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_other_info_galaxy_other_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_other_info_galaxy_other_info_id_seq OWNED BY public.galaxy_other_info.galaxy_other_info_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(20) NOT NULL,
    radius_in_km numeric(7,3) NOT NULL,
    orbital_period_in_days numeric(7,3) NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(20) NOT NULL,
    is_habitable boolean,
    planet_type character varying(20),
    no_of_moons integer,
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(20) NOT NULL,
    approx_age_in_billion_years numeric(6,3) NOT NULL,
    has_planets boolean,
    planets_orbiting integer,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_other_info galaxy_other_info_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_other_info ALTER COLUMN galaxy_other_info_id SET DEFAULT nextval('public.galaxy_other_info_galaxy_other_info_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 0.0265, false, 'Barred spiral');
INSERT INTO public.galaxy VALUES (2, 'Ursa Major III', 0.1076, true, 'Dwarf spheroidal');
INSERT INTO public.galaxy VALUES (3, 'Tucana III', 0.2445, true, 'Dwarf spheroidal');
INSERT INTO public.galaxy VALUES (4, 'Barnards Galaxy', 1.8590, false, 'Barred irregular');
INSERT INTO public.galaxy VALUES (5, 'Andromeda Galaxy', 2.5380, false, 'Barred spiral');
INSERT INTO public.galaxy VALUES (6, 'Triangulum Galaxy', 2.7200, false, 'Spiral');


--
-- Data for Name: galaxy_other_info; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_other_info VALUES (1, 'Milky Way', 'Sky River', 'Sagittarius', 'Where our solar system is, and is also home to about 100-400 billion stars and planets', 1);
INSERT INTO public.galaxy_other_info VALUES (2, 'Ursa Major III', 'UNIONS 1', 'Ursa Major', 'A Milky Way satellite dwarf galaxy, smallest and faintest galaxy ever discovered', 2);
INSERT INTO public.galaxy_other_info VALUES (3, 'Tucana III', 'Toucan III', 'Tucana', 'Important object of observation; an isolated dwarf spheroidal galaxy located near the edge of the Local Group', 3);
INSERT INTO public.galaxy_other_info VALUES (4, 'Barnards Galaxy', 'NGC 6822', 'Sagittarius', 'Closest non-satellite galaxy to the Milky Way', 4);
INSERT INTO public.galaxy_other_info VALUES (5, 'Andromeda Galaxy', 'Andromeda Nebula', 'Andromeda', 'Largest galaxy in the Local Group with at least 19 satellite galaxies', 5);
INSERT INTO public.galaxy_other_info VALUES (6, 'Triangulum Galaxy', 'Messier-33', 'Triangulum', 'AKA Pinwheel galaxy; most distant naked eye object and third largest galaxy in the Local Group', 6);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'The Moon', 1738.000, 29.530, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', 11.267, 7.660, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', 6.200, 30.310, 4);
INSERT INTO public.moon VALUES (4, 'Io', 1821.600, 1.763, 5);
INSERT INTO public.moon VALUES (5, 'Europa', 1560.800, 3.525, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', 2634.100, 7.155, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', 2410.300, 16.690, 5);
INSERT INTO public.moon VALUES (8, 'Mimas', 198.200, 0.942, 6);
INSERT INTO public.moon VALUES (9, 'Enceladus', 252.100, 1.370, 6);
INSERT INTO public.moon VALUES (10, 'Thetys', 533.100, 1.888, 6);
INSERT INTO public.moon VALUES (11, 'Rhea', 763.800, 4.517, 6);
INSERT INTO public.moon VALUES (12, 'Lapetus', 735.600, 79.331, 6);
INSERT INTO public.moon VALUES (13, 'Dione', 561.400, 2.737, 6);
INSERT INTO public.moon VALUES (14, 'Ariel', 578.900, 2.521, 7);
INSERT INTO public.moon VALUES (15, 'Miranda', 235.800, 1.414, 7);
INSERT INTO public.moon VALUES (16, 'Titania', 788.900, 8.706, 7);
INSERT INTO public.moon VALUES (17, 'Oberon', 761.400, 13.464, 7);
INSERT INTO public.moon VALUES (18, 'Umbriel', 584.700, 4.144, 7);
INSERT INTO public.moon VALUES (19, 'Triton', 1353.400, 5.877, 8);
INSERT INTO public.moon VALUES (20, 'Proteus', 210.000, 1.122, 8);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', false, 'Terrestial', 0, 1);
INSERT INTO public.planet VALUES (2, 'Venus', false, 'Terrestial', 0, 1);
INSERT INTO public.planet VALUES (3, 'Earth', true, 'Terrestial', 1, 1);
INSERT INTO public.planet VALUES (4, 'Mars', false, 'Terrestial', 2, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', false, 'Gas Giant', 97, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', false, 'Gas Giant', 274, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', false, 'Ice Giant', 28, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', false, 'Ice Giant', 16, 1);
INSERT INTO public.planet VALUES (9, 'Proxima b', true, 'Terrestial', NULL, 7);
INSERT INTO public.planet VALUES (10, 'Proxima c', false, 'Gas Giant', NULL, 7);
INSERT INTO public.planet VALUES (11, '51 Pegasi b', false, 'Gas Giant', NULL, 6);
INSERT INTO public.planet VALUES (12, 'Kepler-452b', true, 'Terrestial', NULL, 8);
INSERT INTO public.planet VALUES (13, 'Trappist-1e', true, 'Terrestial', NULL, 9);
INSERT INTO public.planet VALUES (14, 'Trappist-1f', true, 'Terrestial', NULL, 9);
INSERT INTO public.planet VALUES (15, 'Trappist-1g', true, 'Terrestial', NULL, 9);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 4.603, true, 8, 1);
INSERT INTO public.star VALUES (2, 'Sirius', 0.250, false, 0, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 0.008, false, 0, 1);
INSERT INTO public.star VALUES (4, 'Vega', 0.475, false, 0, 1);
INSERT INTO public.star VALUES (5, 'Altair', 1.250, false, 0, 1);
INSERT INTO public.star VALUES (6, '51 Pegasi', 7.000, true, 1, 1);
INSERT INTO public.star VALUES (7, 'Proxima Centauri', 4.850, true, 2, 1);
INSERT INTO public.star VALUES (8, 'Kepler 452', 6.000, true, 1, 1);
INSERT INTO public.star VALUES (9, 'Trappist-1', 7.605, true, 7, 1);
INSERT INTO public.star VALUES (10, 'Mayall II', 11.500, NULL, NULL, 5);
INSERT INTO public.star VALUES (11, 'NGC 206 ', 0.020, NULL, NULL, 5);
INSERT INTO public.star VALUES (12, 'Hubble V ', 0.010, NULL, NULL, 4);
INSERT INTO public.star VALUES (13, 'Hubble X ', 0.010, NULL, NULL, 4);
INSERT INTO public.star VALUES (14, 'NGC 604 ', 0.010, NULL, NULL, 6);
INSERT INTO public.star VALUES (15, 'The OB Associations ', 0.030, NULL, NULL, 6);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: galaxy_other_info_galaxy_other_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_other_info_galaxy_other_info_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 15, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 15, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy_other_info galaxy_other_info_also_known_as_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_other_info
    ADD CONSTRAINT galaxy_other_info_also_known_as_key UNIQUE (also_known_as);


--
-- Name: galaxy_other_info galaxy_other_info_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_other_info
    ADD CONSTRAINT galaxy_other_info_name_key UNIQUE (name);


--
-- Name: galaxy_other_info galaxy_other_info_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_other_info
    ADD CONSTRAINT galaxy_other_info_pkey PRIMARY KEY (galaxy_other_info_id);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy_other_info fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_other_info
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star fk_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fk_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

