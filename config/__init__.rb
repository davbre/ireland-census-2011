require 'pry'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'fileutils'
require 'csv'
require 'json'
require_relative '../helpers/helpers'

CSO_CENSUS_2011_HOME = "http://data.cso.ie/"
CSO_CENSUS_2011_LINK_PAGE = CSO_CENSUS_2011_HOME + "datasets/"
CSO_CENSUS_2011_DOWNLOAD_PAGE = CSO_CENSUS_2011_HOME + "downloads/"
OUTPUT_DIR = "output/"
CONFIG_DIR = "config/"
DOWNLOADS_DIR = "downloads/"
DATAPACKAGE_DIR = "datapackage/"
