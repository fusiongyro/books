--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Ubuntu 10.4-0ubuntu0.18.04)
-- Dumped by pg_dump version 10.4 (Ubuntu 10.4-0ubuntu0.18.04)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: isn; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS isn WITH SCHEMA public;


--
-- Name: EXTENSION isn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION isn IS 'data types for international product numbering standards';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: books; Type: TABLE; Schema: public; Owner: dlyons
--

CREATE TABLE public.books (
    isbn public.isbn NOT NULL,
    title character varying,
    author character varying
);


ALTER TABLE public.books OWNER TO dlyons;

--
-- Name: lends; Type: TABLE; Schema: public; Owner: dlyons
--

CREATE TABLE public.lends (
    isbn public.isbn NOT NULL,
    email character varying,
    lent_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    returned_on timestamp without time zone
);


ALTER TABLE public.lends OWNER TO dlyons;

--
-- Name: people; Type: TABLE; Schema: public; Owner: dlyons
--

CREATE TABLE public.people (
    name character varying,
    email character varying NOT NULL
);


ALTER TABLE public.people OWNER TO dlyons;

--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: dlyons
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (isbn);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: dlyons
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (email);


--
-- Name: lends lends_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dlyons
--

ALTER TABLE ONLY public.lends
    ADD CONSTRAINT lends_email_fkey FOREIGN KEY (email) REFERENCES public.people(email);


--
-- Name: lends lends_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dlyons
--

ALTER TABLE ONLY public.lends
    ADD CONSTRAINT lends_isbn_fkey FOREIGN KEY (isbn) REFERENCES public.books(isbn);


--
-- PostgreSQL database dump complete
--

