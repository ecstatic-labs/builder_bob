-- This is generated file, do not edit.
--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

-- SET search_path = public, pg_catalog;

--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: kevinbahr
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE books DISABLE TRIGGER ALL;

INSERT INTO books (id, title, created_at, updated_at) VALUES (1, 'Game of Thrones', '2017-01-09 20:45:40.036101', '2017-01-09 20:45:40.036101');
INSERT INTO books (id, title, created_at, updated_at) VALUES (2, 'A Clash of Kings', '2017-01-09 20:45:40.039626', '2017-01-09 20:45:40.039626');


ALTER TABLE books ENABLE TRIGGER ALL;

--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kevinbahr
--

SELECT pg_catalog.setval('books_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

