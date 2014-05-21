--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: page_blocks; Type: TABLE; Schema: public; Owner: mrcr; Tablespace: 
--

CREATE TABLE page_blocks (
    id integer NOT NULL,
    page_id integer,
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.page_blocks OWNER TO mrcr;

--
-- Name: page_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: mrcr
--

CREATE SEQUENCE page_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_blocks_id_seq OWNER TO mrcr;

--
-- Name: page_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mrcr
--

ALTER SEQUENCE page_blocks_id_seq OWNED BY page_blocks.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: mrcr; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    title text,
    slug text,
    html_title text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    body text,
    summary text,
    published_at timestamp without time zone
);


ALTER TABLE public.pages OWNER TO mrcr;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: mrcr
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO mrcr;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mrcr
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: schema_info; Type: TABLE; Schema: public; Owner: mrcr; Tablespace: 
--

CREATE TABLE schema_info (
    version integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.schema_info OWNER TO mrcr;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mrcr
--

ALTER TABLE ONLY page_blocks ALTER COLUMN id SET DEFAULT nextval('page_blocks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mrcr
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: page_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: mrcr; Tablespace: 
--

ALTER TABLE ONLY page_blocks
    ADD CONSTRAINT page_blocks_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: mrcr; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: page_blocks_page_id_index; Type: INDEX; Schema: public; Owner: mrcr; Tablespace: 
--

CREATE INDEX page_blocks_page_id_index ON page_blocks USING btree (page_id);


--
-- Name: pages_published_at_index; Type: INDEX; Schema: public; Owner: mrcr; Tablespace: 
--

CREATE INDEX pages_published_at_index ON pages USING btree (published_at);


--
-- Name: pages_slug_index; Type: INDEX; Schema: public; Owner: mrcr; Tablespace: 
--

CREATE UNIQUE INDEX pages_slug_index ON pages USING btree (slug);


--
-- Name: page_blocks_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mrcr
--

ALTER TABLE ONLY page_blocks
    ADD CONSTRAINT page_blocks_page_id_fkey FOREIGN KEY (page_id) REFERENCES pages(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: mrcr
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM mrcr;
GRANT ALL ON SCHEMA public TO mrcr;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

