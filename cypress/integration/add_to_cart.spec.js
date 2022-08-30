describe('Jungle testing', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("Click on first product", () => {
    cy.get(".products article").first().click();
    cy.get('.nav-link').contains('My Cart (0)').should('be.visible');
    cy.get('.btn').click();
    cy.get('.nav-link').contains('My Cart (1)').should('be.visible');
  });
});