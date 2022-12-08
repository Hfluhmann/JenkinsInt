require 'selenium-webdriver'
require 'test-unit'
class  RecipeTests < Test::Unit::TestCase
    def setup
        @url = 'http://localhost:3000'
        #constantes xpath
        @btn_crear = '//a[contains(text(),"Crear Receta")]'
        @btn_volver_lista_recetas = '//a[contains(text(),"Volver a Recetas")]'
        @first_recipe = '//tbody/tr[1]/td[1]/a'
        @last_recipe = '//tbody/tr[last()]/td[1]/a'
        @btn_edit_first_recipe = '//tbody/tr[1]/td[last()]/a'
        @btn_edit_last_recipe = '//tbody/tr[last()]/td[last()]/a'
        @title = '//div/p/strong[contains(text(),"Título")]'
        @ingredients = '//div/p/strong[contains(text(),"Ingredientes")]'
        @instructions = '//div/p/strong[contains(text(),"Instrucciones")]'
        @confirmation_message_create = '//p[contains(text(),"Receta creada correctamente")]'
        @confirmation_message_edit = '//p[contains(text(),"Receta actualizada correctamente")]'

        #constantes name
        @title_form = 'recipe[title]'
        @ingredients_form = 'recipe[ingredients]'
        @instructions_form = 'recipe[instructions]'
        @btn_send = 'commit'
    end

    #Visualizar receta
    def test_view_recipe
        @driver = Selenium::WebDriver.for :chrome
        @driver.get(@url)
        @driver.manage.window.maximize
        sleep 2
        first_recipe = @driver.find_element(xpath: @first_recipe)
        first_recipe.click
        sleep 2
        assert(@driver.find_element(xpath: @title).text.include?("Título"), "No title was found")
        assert(@driver.find_element(xpath: @ingredients).text.include?("Ingredientes"), "No ingredients where found")
        assert(@driver.find_element(xpath: @instructions).text.include?("Instrucciones"),"No instructions where found")

    end
    def teardown
        @driver.quit
    end
end