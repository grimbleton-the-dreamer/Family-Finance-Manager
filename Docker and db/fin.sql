--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg24.04+2)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg24.04+2)

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
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    assetid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    initialpurchasedate timestamp without time zone NOT NULL,
    purchaseprice numeric(10,2) NOT NULL,
    desiredlifespan integer NOT NULL
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    expenseid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    amount numeric(10,2) NOT NULL,
    duedate timestamp without time zone NOT NULL,
    description character varying(255),
    recurring boolean NOT NULL
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- Name: goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goals (
    goalid character varying(255) NOT NULL,
    userid character varying(255) NOT NULL,
    targetamount numeric(10,2) NOT NULL,
    progress character varying(255),
    category character varying(50) NOT NULL,
    deadline timestamp without time zone NOT NULL,
    CONSTRAINT goals_category_check CHECK (((category)::text = ANY ((ARRAY['savings'::character varying, 'goals'::character varying])::text[])))
);


ALTER TABLE public.goals OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    yearlysalary numeric(10,2),
    bankamount numeric(10,2),
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'not admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assets (assetid, userid, name, initialpurchasedate, purchaseprice, desiredlifespan) FROM stdin;
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expenses (expenseid, userid, category, amount, duedate, description, recurring) FROM stdin;
\.


--
-- Data for Name: goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goals (goalid, userid, targetamount, progress, category, deadline) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, name, password, role, yearlysalary, bankamount) FROM stdin;
\.


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (assetid);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (expenseid);


--
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (goalid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: assets assets_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: expenses expenses_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: goals goals_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- PostgreSQL database dump complete
--

