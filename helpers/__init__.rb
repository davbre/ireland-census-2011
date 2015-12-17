require 'pry'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'fileutils'
require 'csv'
require_relative 'helpers'

CSO_CENSUS_2011_HOME = "http://data.cso.ie/"
CSO_CENSUS_2011_LINK_PAGE = CSO_CENSUS_2011_HOME + "datasets/"
CSO_CENSUS_2011_DOWNLOAD_PAGE = CSO_CENSUS_2011_HOME + "downloads/"
OUTPUT_DIR = "output/"
DOWNLOADS_DIR = "downloads/"
