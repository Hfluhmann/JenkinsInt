require 'selenium-webdriver'
require 'test-unit'
class  RecipeTests < Test::Unit::TestCase
    def setup
        @url = 'https://0002-181-43-32-119.sa.ngrok.io/'
        @image = '/home/mrjanz/Downloads/image.png'
        #constantes xpath
        @btn_ngrok = '//button'
        @btn_crear = '//a[contains(text(),"Crear Receta")]'
        @btn_volver_lista_recetas = '//a[contains(text(),"Volver a Recetas")]'
        @first_recipe = '//tbody/tr[1]/td[1]/a'
        @last_recipe = '//tbody/tr[last()]/td[1]/a'
        @btn_edit_first_recipe = '//tbody/tr[1]/td[last()]/a'
        @btn_edit_last_recipe = '//tbody/tr[last()]/td[last()]/a'
        @btn_delete_first_recipe = '//tbody/tr[1]/td[last()]/form/button'
        @title = '//div/p/strong[contains(text(),"Título")]'
        @ingredients = '//div/p/strong[contains(text(),"Ingredientes")]'
        @instructions = '//div/p/strong[contains(text(),"Instrucciones")]'
        @confirmation_message_create = '//p[contains(text(),"Receta creada correctamente")]'
        @confirmation_message_edit = '//p[contains(text(),"Receta actualizada correctamente")]'
        @confirmation_message_delete = '//p[contains(text(), "Receta eliminada correctamente")]'

        #constantes name
        @title_form = 'recipe[title]'
        @ingredients_form = 'recipe[ingredients]'
        @instructions_form = 'recipe[instructions]'
        @image_upload = 'recipe[image]'
        @btn_send = 'commit'
        @driver = Selenium::WebDriver.for :chrome
        @driver.get(@url)
        @driver.manage.window.maximize
        sleep 2
        btn_ngrok = @driver.find_element(xpath: @btn_ngrok)
        btn_ngrok.click
    end

    #Visualizar receta
    def test_1view_recipe
        first_recipe = @driver.find_element(xpath: @first_recipe)
        first_recipe.click
        sleep 2
        assert(@driver.find_element(xpath: @title).text.include?("Título"), "No title was found")
        assert(@driver.find_element(xpath: @ingredients).text.include?("Ingredientes"), "No ingredients where found")
        assert(@driver.find_element(xpath: @instructions).text.include?("Instrucciones"),"No instructions where found")
    end

    #Agregar receta
    def test_2create_recipe
        btn_crear_receta = @driver.find_element(xpath: @btn_crear)
        btn_crear_receta.click
        sleep 2
        title_form = @driver.find_element(name: @title_form)
        title_form.send_keys("Suspiro Limeño")
        ingredients_form = @driver.find_element(name: @ingredients_form)
        ingredients_form.send_keys("2 Tarros de leche evaporada IDEAL® NESTLÉ®
        2 Tarros de leche condensada NESTLÉ®
        Canela en polvo para decorar
        6 Yemas de huevo
        1 Cucharada de esencia de vainilla
        Merengue:
        1/2 Taza de oporto o vino añejado
        1 Taza de azúcar 200 g
        100 g de claras 4 a 5 claras de huevos medianos")
        instructions_form = @driver.find_element(name: @instructions_form)
        instructions_form.send_keys("1.  Junta en una cacerola mediana la leche condensada NESTLÉ® con la leche evaporada IDEAL® NESTLÉ® y revuelve para homogenizar. Luego llévalo a fuego medio y cocina durante 20 a 30 minutos aproximados removiendo seguidamente hasta obtener una textura más espesa y cremosa, de color levemente más oscuro. Baja el fuego al mínimo y separa un poco de esta preparación y junta con las yemas de huevo en un bowl pequeño, bate muy bien y pásalo por un colador para añadir a la cacerola y volver a cocinar a fuego bajo durante 5 a 10 minutos “sin que hierva” revolviendo constantemente hasta espesar más, finalmente añade la vainilla y retira del fuego. Una ves listo porciona en pocillos individuales y espera a que se enfríe.
        2.  Mientras, junta en una olla pequeña o sartén (muy limpio) el oporto con el azúcar, lleva a fuego medio durante 8 a 10 minutos removiendo de vez en cuando desde el mango de la cacerola, (no introducir cucharas para remover) cocina hasta obtener un almíbar punto pelo, esto es; que al introducir y levantar la punta de una cuchara en el almíbar debe quedar un pelo delgado colgando.
        3. Cuando el almíbar este casi listo, bate las claras de huevo a punto de nieve y de inmediato vierte el almíbar poco a poco (desde un costado del bowl) batiendo constantemente hasta conseguir unificar ambas preparaciones, bate durante 4 a 6 minutos más hasta que el merengue tome brillo y mayor textura. Cubre en forma decorativa sobre los pocillos con al crema de base y refrigera para disfrutarlos bien fríos.")
        btn_send = @driver.find_element(name: @btn_send)
        btn_send.click
        sleep 2
        assert_not_nil(@driver.find_element(xpath: @confirmation_message_create), "The recipe was not created.")
    end
    def test_3edit_recipe
        btn_edit_last_recipe = @driver.find_element(xpath: @btn_edit_last_recipe)
        btn_edit_last_recipe.click
        sleep 2
        title_form = @driver.find_element(name: @title_form)
        title_form.clear
        title_form.send_keys("Postre limeño")
        btn_send = @driver.find_element(name: @btn_send)
        @driver.find_element(name: @image_upload).send_keys(@image)
        btn_send.click
        sleep 2
        assert_not_nil(@driver.find_element(xpath: @confirmation_message_edit), "The recipe was not edited.")
    end
    def test_4delete_recipe
        sleep 2
        btn_delete_first_recipe = @driver.find_element(xpath: @btn_delete_first_recipe)
        btn_delete_first_recipe.click
        sleep 2
        assert_not_nil(@driver.find_element(xpath: @confirmation_message_delete), "The recipe was not deleted.")
    end
    def teardown
        @driver.quit
    end
end